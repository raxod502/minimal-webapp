#!/bin/bash

(java -jar ../target/minimal-webapp-standalone.jar & echo $! > server_pid.tmp) | fgrep -q 'Started server on port 5000.'
