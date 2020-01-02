#!/bin/bash

# System Manager / Session Manager
# https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-install-ssm-agent.html
# SSM Agent is installed, by default, on Amazon Linux base AMIs dated 2017.09 and later.
# SSM Agent is also installed, by default, on Amazon Linux 2, Ubuntu Server 16.04, and Ubuntu Server 18.04 LTS AMIs.
# You must manually install SSM Agent on other versions of Linux, including non-base images like Amazon ECS-Optimized AMIs.

# Exit immediately if a pipeline [...] returns a non-zero status.
set -e
# Treat unset variables and parameters [...] as an error when performing parameter expansion (substituting).
set -u
# Print a trace of simple commands
set -x

## Code Deploy Agent Bootstrap Script##
AUTOUPDATE=false

f_installdep() {
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/amazon-linux-ami-basics.html#extras-library
  # https://aws.amazon.com/amazon-linux-2/release-notes/

  # aws-cli installed by default
  # jq is a lightweight and flexible command-line JSON processor

  # Docker is only in extras
  # The package for Docker is only available through extras and is enabled by default.
  # When new versions of Docker are released, support will be provided only for the most current stable packages.

  yum -y update
  yum install -y jq ruby docker

  # We do not install docker-compose with this script.
}

f_codedeploy_setup() {
  cd /tmp/
  wget https://aws-codedeploy-$REGION.s3.amazonaws.com/latest/install
  chmod +x ./install

  if ./install auto; then
    echo "Instalation completed"
      if ! $AUTOUPDATE; then
          echo "Disabling auto update"
          sed -i '/@reboot/d' /etc/cron.d/codedeploy-agent-update
          chattr +i /etc/cron.d/codedeploy-agent-update
          rm -f /tmp/install
      fi
    exit 0
  else
    echo "Instalation script failed, please investigate"
    rm -f /tmp/install
    exit 1
  fi
}

f_docker_setup() {
  systemctl enable docker
  systemctl start docker
}

f_main() {
  f_installdep
  f_docker_setup
  REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")
  f_codedeploy_setup
}

f_main 2>&1 | tee -a ~/bootstrap.log
