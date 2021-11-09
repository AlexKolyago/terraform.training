#!/bin/bash

echo "Hello, World, v2.0" > index.html
nohup busybox httpd -f -p ${server_port} &