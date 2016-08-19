#!/bin/bash

set -e
set -o pipefail

try_to_kill() {
    kill $1 2>/dev/null || true
}

free_port() {
    echo "--> Free port $PORT"
    lsof -t -i :$PORT | xargs kill 2>/dev/null || true
}

clean_and_create_uberjar() {
    echo '--> Clean and create uberjar'
    lein do clean, uberjar
}

start_server_from_uberjar() {
    echo '--> Start server from uberjar'
    java -jar ../target/minimal-webapp-standalone.jar > stdout.tmp &
    SERVER_PID=$!
    tail -n +1 -f stdout.tmp | while read line; do
        if [[ $line =~ 'Server started on port 5000.' ]]; then
            echo line start
            pkill -15 -P $$ tail
            echo line end
        fi
    done
    echo done
    # needs timeout
}

verify_webpage_is_served() {
    echo "--> Verify that webpage is served on localhost:$PORT"
    phantomjs get_html.js "http://localhost:$PORT" | fgrep -q 'Hello from Reagent!' || (echo '----> Webpage not served'; false)
}

kill_server() {
    echo "--> Kill server"
    try_to_kill $SERVER_PID
    pkill -15 -P $$ tail
    rm -f server_startup.log
}

cleanup() {
    echo '----> Error, cleaning up'
    kill_server
    free_port
}

uberjar_test() {
    start_server_from_uberjar
    kill_server
}

PORT=5000
free_port
trap cleanup EXIT

uberjar_test

trap EXIT
