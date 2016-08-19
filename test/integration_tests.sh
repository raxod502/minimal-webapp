#!/usr/bin/env bash

echo '##### RUNNING FROM UBERJAR'
phantomjs autotest.js \
    run command 'lein do clean, uberjar' \
    launch server with command 'java -jar ../target/minimal-webapp-standalone.jar' \
    on port 5000 at root path \
    reload until text 'Hello from Reagent' observed with timeout of 30 seconds \

echo '##### RUNNING FROM -MAIN'
phantomjs autotest.js \
    run command 'lein clean' \
    launch cljsbuild with command 'lein cljsbuild auto' \
    launch server with command 'lein run -m minimal-webapp.server' \
    on port 5000 at root path \
    reload until text 'Hello from Reagent' observed with timeout of 30 seconds \
    on error run command './goodbye_to_hello.sh' \
    run command './hello_to_goodbye.sh' \
    reload until text 'Goodbye from Reagent' observed with timeout of 30 seconds \
    run command './goodbye_to_hello.sh'

echo '##### RUNNING FROM REPL'
phantomjs autotest.js \
    run command 'lein clean' \
    launch cljsbuild with command 'lein cljsbuild auto' \
    launch repl with command 'lein repl' \
    send input "(require 'minimal-webapp.server)" to repl \
    send input "(in-ns 'minimal-webapp.server)" to repl \
    send input "(start)" to repl \
    on port 5000 at root path \
    reload until text 'Hello from Reagent' observed with timeout of 60 seconds \
    on error run command './goodbye_to_hello.sh' \
    run command './hello_to_goodbye.sh' \
    reload until text 'Goodbye from Reagent' observed with timeout of 30 seconds \
    run command './goodbye_to_hello.sh' \
    on error run command './maximal_to_minimal.sh' \
    run command './minimal_to_maximal.sh' \
    send input "(require 'minimal-webapp.server :reload)" to repl \
    reload until text 'Maximal Webapp' observed with timeout of 30 seconds \
    run command './maximal_to_minimal.sh' \
    on error run command './remove_clj_message.sh' \
    run command './add_clj_message.sh' \
    send input "(require 'minimal-webapp.server :reload)" to repl # need to check if this is necessary \
    on error run command 'rm result.tmp' \
    send input '(spit "test/result.tmp" clj-message)' to repl \
    wait until text 'Clojure Message' observed in file result.tmp with timeout of 10 seconds \
    run command 'rm result.tmp' \
    run command './remove_clj_message.sh'

echo '##### RUNNING FROM FIGWHEEL'
phantomjs autotest.js \
    run command 'lein clean' \
    launch repl with command 'lein repl' \
    launch figwheel with command 'rlwrap lein figwheel' \
    on port 3449 at root path \
    reload until text 'Hello from Reagent' observed with timeout of 60 seconds \
    send input '(js/alert "Is Figwheel connected?")' to figwheel # might need to delay before this \
    wait until alert observed with timeout of 10 seconds \
    on error run command './goodbye_to_hello.sh' \
    run command './hello_to_goodbye.sh' \
    wait until text 'Goodbye from Reagent' observed with timeout of 30 seconds \
    run command './goodbye_to_hello.sh' \
    on error run command './maximal_to_minimal.sh' \
    run command './minimal_to_maximal.sh' \
    reload until text 'Maximal Webapp' observed with timeout of 30 seconds \
    run command './maximal_to_minimal.sh' \
    on error run command './remove_cljs_message.sh' \
    run command './add_cljs_message.sh' \
    send input "(in-ns 'minimal-webapp.pages.splash)" to figwheel \
    on error run command 'rm result.tmp' \
    send input '(spit "test/result.tmp" cljs-message)' to figwheel \
    wait until text 'ClojureScript Message' observed in file result.tmp with timeout of 10 seconds \
    run command 'rm result.tmp' \
    run command './remove_cljs_message.sh' \
    on error run command './remove_clj_message.sh' \
    run command './add_clj_message.sh' \
    send input "(require 'minimal-webapp.server)" to repl \
    send input "(in-ns 'minimal-webapp.server)" to repl \
    send input '(spit "test/result.tmp" clj-message)' to repl \
    wait until text 'Clojure Message' observed in file result.tmp with timeout of 10 seconds \
    run command 'rm result.tmp' \
    run command './remove_clj_message.sh'

echo '##### RUNNING FROM FIGWHEEL SIDECAR'
phantomjs autotest.js \
    run command 'lein clean' \
    launch clj-repl with command 'lein repl' \
    launch cljs-repl with command 'lein repl' \
    on port 3449 at root path \
    reload until text 'Hello from Reagent' observed with timeout of 60 seconds \
    send input '(js/alert "Is Figwheel connected?")' to figwheel # might need to delay before this \
    wait until alert observed with timeout of 10 seconds \
    on error run command './goodbye_to_hello.sh' \
    run command './hello_to_goodbye.sh' \
    wait until text 'Goodbye from Reagent' observed with timeout of 30 seconds \
    run command './goodbye_to_hello.sh' \
    on error run command './maximal_to_minimal.sh' \
    run command './minimal_to_maximal.sh' \
    reload until text 'Maximal Webapp' observed with timeout of 30 seconds \
    run command './maximal_to_minimal.sh' \
    on error run command './remove_cljs_message.sh' \
    run command './add_cljs_message.sh' \
    send input "(in-ns 'minimal-webapp.pages.splash)" to figwheel \
    on error run command 'rm result.tmp' \
    send input '(spit "test/result.tmp" cljs-message)' to figwheel \
    wait until text 'ClojureScript Message' observed in file result.tmp with timeout of 10 seconds \
    run command 'rm result.tmp' \
    run command './remove_cljs_message.sh' \
    on error run command './remove_clj_message.sh' \
    run command './add_clj_message.sh' \
    send input "(require 'minimal-webapp.server)" to repl \
    send input "(in-ns 'minimal-webapp.server)" to repl \
    send input '(spit "test/result.tmp" clj-message)' to repl \
    wait until text 'Clojure Message' observed in file result.tmp with timeout of 10 seconds \
    run command 'rm result.tmp' \
    run command './remove_clj_message.sh'

