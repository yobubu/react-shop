#!/bin/bash

# Exit immediately if a pipeline [...] returns a non-zero status.
set -e
# Treat unset variables and parameters [...] as an error when performing parameter expansion (substituting).
set -u
# Print a trace of simple commands
set -x

apt -y update

f_installtools() {

# Run prometheus-server, node-exporter, grafana
# TODO remove duplicate metrics and add labels
  git clone https://gitlab.com/pawelfraczyk/react-shop.git
  cd react-shop/tools
  export EC2_PUBLIC_HOSTNAME=$(curl http://169.254.169.254/2020-10-27/meta-data/public-hostname)
  export GRAYLOG_HTTP_EXTERNAL_URI=$(echo "http://$EC2_PUBLIC_HOSTNAME:9000/")
  docker-compose up -d
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

f_installgray() {
  docker run --link mongo --link elasticsearch \
    --name graylog \
    -p 9000:9000 -p 12201:12201 -p 1514:1514 -p 5555:5555/udp \
    -e GRAYLOG_HTTP_EXTERNAL_URI="http://ec2-54-155-147-146.eu-west-1.compute.amazonaws.com:9000/" \
    -d graylog/graylog:4.0
}

f_main() {
  f_installdock
  f_installprom
}

f_main 2>&1 | tee -a ~/bootstrap.log