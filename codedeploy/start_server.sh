#!/bin/bash

# During this deployment lifecycle event, the AWS CodeDeploy agent
# copies the application revision files to a temporary location:
# /opt/codedeploy-agent/deployment-root/deployment-group-id/deployment-id/deployment-archive

# https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file-structure-hooks.html
# supported variables set by the CodeDeploy agent:
# APPLICATION_NAME
# DEPLOYMENT_ID
# DEPLOYMENT_GROUP_NAME
# DEPLOYMENT_GROUP_ID
# LIFECYCLE_EVENT

# Exit immediately if a pipeline [...] returns a non-zero status.
set -e
# Treat unset variables and parameters [...] as an error when performing parameter expansion (substituting).
set -u
# Print a trace of simple commands
set -x

# env
# pwd

# EC2s are configured with instance profile (a specific role) and all the required policies.

# Login to ecr
eval $(aws ecr get-login --no-include-email --region eu-west-1)

# Environment variables retrieved from System Manager / Parameter Store
cd /opt/codedeploy-agent/deployment-root/${DEPLOYMENT_GROUP_ID}/${DEPLOYMENT_ID}/deployment-archive

REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")
VARS=$(aws --region $REGION ssm get-parameters-by-path --recursive --path /toptal-task/ --with-decryption | jq -r '.Parameters | .[] | .Name + "=" + .Value' | sed -e s#/toptal-task/##g)
for envvar in ${VARS}; do
  echo $envvar >> .env;
  export $envvar;
done

COMPOSE="docker-compose -p ${APPLICATION_NAME} -f docker-compose.yml"
${COMPOSE} pull api
${COMPOSE} up -d api
${COMPOSE} up -d node-exporter
# Remove unused data, do not prompt for confirmation
docker image prune -f