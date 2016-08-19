#!/bin/bash

(lein run -m minimal-webapp.server & echo $! > server_pid.tmp) | fgrep -q 'Started server on port 5000.'
