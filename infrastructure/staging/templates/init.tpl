#!/bin/bash

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
  # ruby is a CodeDeploy dependency

  yum -y update
  yum install -y jq docker

  if ! [ -x /usr/bin/docker-compose ]; then
      curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
      chmod +x /usr/bin/docker-compose
  fi
}

f_docker_setup() {
  systemctl enable docker
  systemctl start docker
}

f_codedeploy_setup() {
  cd /tmp/
  wget https://aws-codedeploy-$REGION.s3.$REGION.amazonaws.com/latest/install
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

f_main() {
  f_installdep
  f_docker_setup
  REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")
  f_codedeploy_setup
}

f_main 2>&1 | tee -a ~/bootstrap.log
