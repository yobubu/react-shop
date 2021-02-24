#!/bin/bash

if [ `curl -s -u admin:admin -H 'Content-Type: application/json' -X GET 'http://localhost:9000/api/system/inputs' | grep -c 'Standard GELF UDP input'` == 0 ]
then
  curl -u admin:admin -H 'Content-Type: application/json' -X POST 'http://localhost:9000/api/system/inputs' -d '{
    "title": "Standard GELF UDP input",
    "type": "org.graylog2.inputs.gelf.udp.GELFUDPInput",
    "global": true,
    "configuration":   {
          "recv_buffer_size": 262144,
          "tcp_keepalive": false,
          "use_null_delimiter": true,
          "number_worker_threads": 2,
          "bind_address": "0.0.0.0",
          "decompress_size_limit": 8388608,
          "port": 12201,
          "max_message_size": 2097152,
          "override_source": null
        },
    "node": null
  }' -H 'X-Requested-By: cli'
else
  echo "Standard GELF UDP input exists already"
fi