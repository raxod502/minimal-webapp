#!/bin/bash

set -e
set -o pipefail

free_port() {
    echo "--> Free port $PORT"
    lsof -t -i :$PORT | xargs kill 2>/dev/null || true
}

check_webpage() {
    echo "--> Verify that webpage is served on localhost:$PORT"
    phantomjs get_html.js "http://localhost:$PORT" | fgrep -q 'Hello from Reagent!' || (echo '----> Webpage not served'; false)
}

kill_server() {
    echo '--> Kill server'
    (cat server_pid.tmp | xargs kill) 2>/dev/null || true
    rm -f server_pid.tmp
}

cleanup() {
    echo "----> Error, cleaning up"
    kill_server
    free_port
}

uberjar_test() {
    echo '----> Running from uberjar'
    echo '--> Clean and create uberjar'
    #lein do clean, uberjar
    start_server_uberjar
    echo '--> Start server from uberjar'
    #timeout -15 10 ./start_server_uberjar.sh
    check_webpage
    kill_server
}

main_test() {
    echo '----> Running from -main'
    echo '--> Clean and cljsbuild'
    lein do clean, cljsbuild once
    echo '--> Start server from -main'
    timeout -15 30 ./start_server_main.sh
    check_webpage
    kill_server
}

trap cleanup EXIT

PORT=5000
free_port

uberjar_test
#main_test

trap EXIT
