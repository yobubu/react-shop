#!/bin/bash

aws deploy push --application-name $APPLICATION_NAME --s3-location s3://$AWS_S3_BUCKET/$APPLICATION_NAME/$CI_JOB_ID.zip
ID=$(aws deploy create-deployment --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP_NAME --s3-location bucket=$AWS_S3_BUCKET,key=$APPLICATION_NAME/$CI_JOB_ID.zip,bundleType=zip --output text --query '[deploymentId]')
STATUS=$(aws deploy get-deployment --deployment-id $ID --output text --query '[deploymentInfo.status]') 

while [[ $STATUS == "Created" || $STATUS == "InProgress" || $STATUS == "Pending" || $STATUS == "Queued" || $STATUS == "Ready" ]]; do
    echo "Status: $STATUS..."
    STATUS=$(aws deploy get-deployment --deployment-id $ID --output text --query '[deploymentInfo.status]')
    sleep 5
done

if [[ $STATUS == "Succeeded" ]]; then
  EXITCODE=0
  echo "Deployment finished."
else
  EXITCODE=1
  echo "Deployment failed!"
fi

aws deploy get-deployment --deployment-id $ID
exit $EXITCODE