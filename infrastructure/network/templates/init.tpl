#!/bin/bash

# Exit immediately if a pipeline [...] returns a non-zero status.
set -e
# Treat unset variables and parameters [...] as an error when performing parameter expansion (substituting).
set -u
# Print a trace of simple commands
set -x

f_installprom() {

  useradd --no-create-home prometheus
  mkdir /etc/prometheus
  mkdir /var/lib/prometheus

  wget https://github.com/prometheus/prometheus/releases/download/v2.19.0/prometheus-2.19.0.linux-amd64.tar.gz
  tar xvfz prometheus-2.19.0.linux-amd64.tar.gz

  cp prometheus-2.19.0.linux-amd64/prometheus /usr/local/bin
  cp prometheus-2.19.0.linux-amd64/promtool /usr/local/bin/
  cp -r prometheus-2.19.0.linux-amd64/consoles /etc/prometheus
  cp -r prometheus-2.19.0.linux-amd64/console_libraries /etc/prometheus

  cp prometheus-2.19.0.linux-amd64/promtool /usr/local/bin/
  rm -rf prometheus-2.19.0.linux-amd64.tar.gz prometheus-2.19.0.linux-amd64

  cat <<EOF >> /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF
  chown prometheus:prometheus /etc/prometheus
  chown prometheus:prometheus /usr/local/bin/prometheus
  chown prometheus:prometheus /usr/local/bin/promtool
  chown -R prometheus:prometheus /etc/prometheus/consoles
  chown -R prometheus:prometheus /etc/prometheus/console_libraries
  chown -R prometheus:prometheus /var/lib/prometheus

  systemctl daemon-reload
  systemctl enable prometheus

  cat <<EOF >> /etc/prometheus/prometheus.yml
global:
  scrape_interval: 1s
  evaluation_interval: 1s

scrape_configs:
  - job_name: 'node'
    ec2_sd_configs:
      - region: eu-west-1
        profile: ec2-tools-profile
        role_arn: arn:aws:iam::088302454178:role/ec2-tools-role
        port: 9100
EOF

  sudo systemctl restart prometheus
}

f_main() {
  f_installprom
}

f_main 2>&1 | tee -a ~/bootstrap.log