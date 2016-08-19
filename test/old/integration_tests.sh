#!/usr/bin/env bash

set -e
set -o pipefail

free_port() {
    echo "--> Freeing port $PORT"
    lsof -t -i :$PORT | xargs kill 2>/dev/null || true
}

failure() {
    echo '----> Encountered error, cleaning up'
    if [[ -n $SERVER_PID ]]; then
        echo '--> Killing server'
        kill $SERVER_PID
    fi
    free_port
}

wait_for_server_start() {
    for i in $(seq 1 $1); do
        phantomjs get_html.js "http://localhost:$PORT/health-check" \
            | fgrep -q 'Server running' \
            && return 0 || sleep 1
    done
    echo '--> Timed out'
    exit 1
}

check_main_page() {
    echo '--> Checking main page'
    phantomjs get_html.js "http://localhost:$PORT" | fgrep -q 'Hello from Reagent!'
}



uberjar_test() {
    echo '--> Cleaning and creating uberjar'
    lein do clean, uberjar
    echo '--> Starting server from uberjar'
    java -jar ../target/minimal-webapp-standalone.jar &
    SERVER_PID=$!
    wait_for_server_start 20
    check_main_page
    echo '--> Killing server'
    kill $SERVER_PID
    SERVER_PID=
}

main_test() {
    echo '--> Cleaning and building ClojureScript'
    #lein do clean, cljsbuild once
    echo '--> Starting server from -main'
    lein run -m minimal-webapp.server &
    SERVER_PID=$!
    wait_for_server_start 35
    check_main_page
    echo '--> Killing server'
    kill $SERVER_PID
    SERVER_PID=
}

PORT=5000
SERVER_PID=
trap failure EXIT
free_port
#uberjar_test
main_test
trap EXIT
