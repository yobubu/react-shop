#!/bin/bash

# Exit immediately if a pipeline [...] returns a non-zero status.
set -e
# Treat unset variables and parameters [...] as an error when performing parameter expansion (substituting).
set -u
# Print a trace of simple commands
set -x

f_preinstall() {
  apt -y update
  apt -y install awscli jq
}

f_installtools() {
  REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")
  VARS=$(aws --region $REGION ssm get-parameters-by-path --recursive --path /toptal-task/ --with-decryption | jq -r '.Parameters | .[] | .Name + "=" + .Value' | sed -e s#/toptal-task/##g)
  for envvar in ${VARS}; do
    echo $envvar >> .env;
    export $envvar;
  done
  git clone https://gitlab.com/pawelfraczyk/react-shop.git
  cd react-shop/tools
  docker-compose up -d
  docker-compose up wait-for
  chmod +x ./config/graylog/input.sh
  ./config/graylog/input.sh
}

f_installdock() {
  #install docker
  apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  
  apt-get -y update
  apt-get -y install docker-ce docker-ce-cli containerd.io

  #install docker-compose
  if ! [ -x /usr/bin/docker-compose ]; then
      curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
      chmod +x /usr/bin/docker-compose
  fi
}

f_main() {
  f_preinstall
  f_installdock
  f_installtools
}

f_main 2>&1 | tee -a ~/bootstrap.log