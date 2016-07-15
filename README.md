# minimal-webapp

## Summary

This is a **minimal** webapp written in Clojure and ClojureScript using Compojure and Reagent, including full integration with Figwheel and Emacs.

## Usage

Install [Leiningen](http://leiningen.org/). From here, you have several options on how to run the application.

### Using CIDER (preferred)

#### Summary

With this setup, Emacs runs Clojure and ClojureScript REPLs which are fully integrated with CIDER and can access the state of the application while it is running. Emacs also runs Figwheel, which will hot-load any ClojureScript code changes into the browser without reloading the page.

#### Setup

If you have CIDER installed, you can use Figwheel from within Emacs. First, press `M-x customize-group` and enter `cider`. Navigate to `Cider Cljs Lein Repl`, set the value to `Figwheel-sidecar`, and save your changes. Now open a Clojure or ClojureScript file in the project and press either `C-c M-J` or `M-x cider-jack-in-clojurescript`. Finally, navigate to [localhost:3449](http://localhost:3449/) in your browser.

In Emacs, you should see two REPLs open. The Clojure REPL should have output similar to the following:

```
;; Connected to nREPL server - nrepl://localhost:50605
;; CIDER 0.13.0snapshot (package: 20160629.946), nREPL 0.2.12
;; Clojure 1.8.0, Java 1.8.0_31
;;     Docs: (doc function-name)
;;           (find-doc part-of-name)
;;   Source: (source function-name)
;;  Javadoc: (javadoc java-object-or-class)
;;     Exit: <C-c C-q>
;;  Results: Stored in vars *1, *2, *3, an exception in *e;
user> 
```

The ClojureScript REPL should have output similar to the following:

```
;; Connected to nREPL server - nrepl://localhost:50605
;; CIDER 0.13.0snapshot (package: 20160629.946), nREPL 0.2.12
;; Clojure 1.8.0, Java 1.8.0_31
;;     Docs: (doc function-name)
;;           (find-doc part-of-name)
;;   Source: (source function-name)
;;  Javadoc: (javadoc java-object-or-class)
;;     Exit: <C-c C-q>
;;  Results: Stored in vars *1, *2, *3, an exception in *e;
user> Figwheel: Starting server at http://localhost:3449
Figwheel: Watching build - main
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 7.967 seconds.
Launching ClojureScript REPL for build: main
Figwheel Controls:
          (stop-autobuild)                ;; stops Figwheel autobuilder
          (start-autobuild [id ...])      ;; starts autobuilder focused on optional ids
          (switch-to-build id ...)        ;; switches autobuilder to different build
          (reset-autobuild)               ;; stops, cleans, and starts autobuilder
          (reload-config)                 ;; reloads build config and resets autobuild
          (build-once [id ...])           ;; builds source one time
          (clean-builds [id ..])          ;; deletes compiled cljs target files
          (print-config [id ...])         ;; prints out build configurations
          (fig-status)                    ;; displays current state of system
  Switch REPL build focus:
          :cljs/quit                      ;; allows you to switch REPL to another build
    Docs: (doc function-name-here)
    Exit: Control+C or :cljs/quit
 Results: Stored in vars *1, *2, *3, *e holds last exception object
Prompt will show when Figwheel connects to your application
To quit, type: :cljs/quit
nil
cljs.user> 
```

You should not be concerned by the message

```
Starting a Figwheel-sidecar REPL (add figwheel-sidecar to your plugins)
```

as this appears even if you have `figwheel-sidecar` correctly configured.

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.
- Enter `(js/alert "Is Figwheel connected?")` at the `cljs.user` prompt. You should receive a pop-up notification from your browser.
- Open `src/minimal_webapp/pages/splash.cljs`, replace the text `"Hello from Reagent!"` with `"Goodbye from Reagent!"`, and save the file. You should see the text in your browser change without needing to reload the page.
- Open `src/minimal_webapp/server.clj`, replace the text `"Minimal Webapp"` with `"Maximal Webapp"`, and save the file. After reloading the page in your browser, you should see the title of the page change.
- Open `src/minimal_webapp/pages/splash.cljs` and press `C-c M-n`. You should see the prompt in the ClojureScript REPL change from `cljs.user>` to `minimal-webapp.pages.splash>`. Now add `(def cljs-message "ClojureScript Message")` just after the namespace declaration, save the file, wait a second or two, and enter `cljs-message` at the ClojureScript REPL. You should get `"ClojureScript Message"` as output.
- Open `src/minimal_webapp/server.clj` and press `C-c M-n`. You should see the prompt in the Clojure REPL change from `user>` to `minimal-webapp.server>`. Now add `(def clj-message "Clojure Message")` just after the namespace declaration, save the file, press `C-c C-k`, and enter `clj-message` at the Clojure REPL. You should get `"Clojure Message"` as output.

#### Shutting down

- Switch to the Clojure REPL and press `C-c C-q` to exit.
- Switch to the ClojureScript REPL and press `C-c C-q` to exit.

### Using Figwheel from within the Clojure REPL

#### Summary

With this setup, you run two separate Clojure REPLs; in one of them, you start Figwheel and a ClojureScript REPL. Both of these REPLs will be able access the state of the application while it is running. Figwheel will hot-load any ClojureScript code changes into the browser without reloading the page. Note that because you are running the ClojureScript REPL inside of a Clojure REPL, tab completion and history will work properly.

#### Setup

You will need two terminal sessions. In the first, run `lein repl` to launch a Clojure REPL. You should receive output similar to the following:

```
nREPL server started on port 50743 on host 127.0.0.1 - nrepl://127.0.0.1:50743
REPL-y 0.3.7, nREPL 0.2.12
Clojure 1.8.0
Java HotSpot(TM) 64-Bit Server VM 1.8.0_31-b13
    Docs: (doc function-name-here)
          (find-doc "part-of-name-here")
  Source: (source function-name-here)
 Javadoc: (javadoc java-object-or-class-here)
    Exit: Control+D or (exit) or (quit)
 Results: Stored in vars *1, *2, *3, an exception in *e

user=>
```

In the second, do the following and navigate to [localhost:3449](http://localhost:3449/) in your browser while the ClojureScript REPL is launching:

```
$ lein repl
nREPL server started on port 50794 on host 127.0.0.1 - nrepl://127.0.0.1:50794
REPL-y 0.3.7, nREPL 0.2.12
Clojure 1.8.0
Java HotSpot(TM) 64-Bit Server VM 1.8.0_31-b13
    Docs: (doc function-name-here)
          (find-doc "part-of-name-here")
  Source: (source function-name-here)
 Javadoc: (javadoc java-object-or-class-here)
    Exit: Control+D or (exit) or (quit)
 Results: Stored in vars *1, *2, *3, an exception in *e

user=> (use 'figwheel-sidecar.repl-api)
nil
user=> (start-figwheel!)
2016-07-15 18:14:47.597:INFO::nREPL-worker-0: Logging initialized @35720ms
Figwheel: Starting server at http://localhost:3449
Figwheel: Watching build - main
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 7.708 seconds.
nil
user=> (cljs-repl)
Launching ClojureScript REPL for build: main
Figwheel Controls:
          (stop-autobuild)                ;; stops Figwheel autobuilder
          (start-autobuild [id ...])      ;; starts autobuilder focused on optional ids
          (switch-to-build id ...)        ;; switches autobuilder to different build
          (reset-autobuild)               ;; stops, cleans, and starts autobuilder
          (reload-config)                 ;; reloads build config and resets autobuild
          (build-once [id ...])           ;; builds source one time
          (clean-builds [id ..])          ;; deletes compiled cljs target files
          (print-config [id ...])         ;; prints out build configurations
          (fig-status)                    ;; displays current state of system
  Switch REPL build focus:
          :cljs/quit                      ;; allows you to switch REPL to another build
    Docs: (doc function-name-here)
    Exit: Control+C or :cljs/quit
 Results: Stored in vars *1, *2, *3, *e holds last exception object
Prompt will show when Figwheel connects to your application
To quit, type: :cljs/quit
nil
cljs.user=>
```

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.
- Enter `(js/alert "Is Figwheel connected?")` at the `cljs.user` prompt. You should receive a pop-up notification from your browser.
- Open `src/minimal_webapp/pages/splash.cljs`, replace the text `"Hello from Reagent!"` with `"Goodbye from Reagent!"`, and save the file. You should see the text in your browser change without needing to reload the page.
- Open `src/minimal_webapp/server.clj`, replace the text `"Minimal Webapp"` with `"Maximal Webapp"`, and save the file. After reloading the page in your browser, you should see the title of the page change.
- Open `src/minimal_webapp/pages/splash.cljs`, add `(def cljs-message "ClojureScript Message")` just after the namespace declaration, and save the file. Now enter `(in-ns 'minimal-webapp.pages.splash)` at the ClojureScript REPL. Finally, enter `cljs-message`. You should get `"ClojureScript Message"` as output.
- Open `src/minimal_webapp/server.clj`, add `(def clj-message "Clojure Message")` just after the namespace declaration, and save the file. Now enter `(require 'minimal-webapp.server)` and `(in-ns 'minimal-webapp.server)` at the Clojure REPL. Finally, enter `clj-message`. You should get `"Clojure Message"` as output.

#### Shutting down

- Press `Control+D` in the Clojure REPL to exit.
- Press `Control+D` in the ClojureScript REPL to exit.

### Using Figwheel from the command line

#### Summary

With this setup, you run a Clojure REPL in one terminal session, and a ClojureScript REPL within Figwheel in another terminal session. Both of these REPLs will be able access the state of the application while it is running. Figwheel will hot-load any ClojureScript code changes into the browser without reloading the page. Using `rlwrap` to call `lein figwheel` allows you to get history in your ClojureScript REPL, but you will still not have tab completion.

#### Setup

First, install [rlwrap](https://github.com/hanslub42/rlwrap) using your package manager of choice (`brew` works).

Now you will need two terminal sessions. In the first, run `lein repl` to launch a Clojure REPL. You should receive output similar to the following:

```
nREPL server started on port 50743 on host 127.0.0.1 - nrepl://127.0.0.1:50743
REPL-y 0.3.7, nREPL 0.2.12
Clojure 1.8.0
Java HotSpot(TM) 64-Bit Server VM 1.8.0_31-b13
    Docs: (doc function-name-here)
          (find-doc "part-of-name-here")
  Source: (source function-name-here)
 Javadoc: (javadoc java-object-or-class-here)
    Exit: Control+D or (exit) or (quit)
 Results: Stored in vars *1, *2, *3, an exception in *e

user=>
```

In the second, run `rlwrap lein figwheel`, and navigate to [localhost:3449](http://localhost:3449/) in your browser. You should receive output similar to the following in your terminal:

```
2016-07-15 18:03:25.125:INFO::main: Logging initialized @7958ms
Figwheel: Starting server at http://localhost:3449
Figwheel: Watching build - main
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 7.035 seconds.
Launching ClojureScript REPL for build: main
Figwheel Controls:
          (stop-autobuild)                ;; stops Figwheel autobuilder
          (start-autobuild [id ...])      ;; starts autobuilder focused on optional ids
          (switch-to-build id ...)        ;; switches autobuilder to different build
          (reset-autobuild)               ;; stops, cleans, and starts autobuilder
          (reload-config)                 ;; reloads build config and resets autobuild
          (build-once [id ...])           ;; builds source one time
          (clean-builds [id ..])          ;; deletes compiled cljs target files
          (print-config [id ...])         ;; prints out build configurations
          (fig-status)                    ;; displays current state of system
  Switch REPL build focus:
          :cljs/quit                      ;; allows you to switch REPL to another build
    Docs: (doc function-name-here)
    Exit: Control+C or :cljs/quit
 Results: Stored in vars *1, *2, *3, *e holds last exception object
Prompt will show when Figwheel connects to your application
To quit, type: :cljs/quit
cljs.user=>
```

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.
- Enter `(js/alert "Is Figwheel connected?")` at the `cljs.user` prompt. You should receive a pop-up notification from your browser.
- Open `src/minimal_webapp/pages/splash.cljs`, replace the text `"Hello from Reagent!"` with `"Goodbye from Reagent!"`, and save the file. You should see the text in your browser change without needing to reload the page.
- Open `src/minimal_webapp/server.clj`, replace the text `"Minimal Webapp"` with `"Maximal Webapp"`, and save the file. After reloading the page in your browser, you should see the title of the page change.
- Open `src/minimal_webapp/pages/splash.cljs`, add `(def cljs-message "ClojureScript Message")` just after the namespace declaration, and save the file. Now enter `(in-ns 'minimal-webapp.pages.splash)` at the ClojureScript REPL. Finally, enter `cljs-message`. You should get `"ClojureScript Message"` as output.
- Open `src/minimal_webapp/server.clj`, add `(def clj-message "Clojure Message")` just after the namespace declaration, and save the file. Now enter `(require 'minimal-webapp.server)` and `(in-ns 'minimal-webapp.server)` at the Clojure REPL. Finally, enter `clj-message`. You should get `"Clojure Message"` as output.

#### Shutting down

- Press `Control+D` in the Clojure REPL to exit.
- Press `Control+C` in the ClojureScript REPL to exit.

### Using the Clojure REPL without Figwheel

#### Summary

In this setup, you run the server manually from a Clojure REPL, while using `lein cljsbuild` to build the ClojureScript. Because you aren't using Figwheel, you will not have hot-code reloading or a ClojureScript REPL. However, you can still see changes to both the Clojure and ClojureScript code in your browser without restarting the server.

#### Setup

To start the server, you will need two terminal sessions. In the first, do:

```
$ lein cljsbuild auto
Watching for changes before compiling ClojureScript...
2016-07-15 12:06:51.023:INFO::main: Logging initialized @6097ms
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 1.654 seconds.
```

In the second, do:

```
$ lein repl
nREPL server started on port 54334 on host 127.0.0.1 - nrepl://127.0.0.1:54334
REPL-y 0.3.7, nREPL 0.2.12
Clojure 1.8.0
Java HotSpot(TM) 64-Bit Server VM 1.8.0_31-b13
    Docs: (doc function-name-here)
          (find-doc "part-of-name-here")
  Source: (source function-name-here)
 Javadoc: (javadoc java-object-or-class-here)
    Exit: Control+D or (exit) or (quit)
 Results: Stored in vars *1, *2, *3, an exception in *e

user=> (require 'minimal-webapp.server)
2016-07-15 12:07:27.393:INFO::nREPL-worker-0: Logging initialized @14185ms
nil
user=> (in-ns 'minimal-webapp.server)
#namespace[minimal-webapp.server]
minimal-webapp.server=> (start)
2016-07-15 12:07:32.305:INFO:oejs.Server:nREPL-worker-0: jetty-9.2.10.v20150310
2016-07-15 12:07:32.342:INFO:oejs.ServerConnector:nREPL-worker-0: Started ServerConnector@1b45036{HTTP/1.1}{0.0.0.0:5000}
2016-07-15 12:07:32.343:INFO:oejs.Server:nREPL-worker-0: Started @19135ms
#object[org.eclipse.jetty.server.Server 0x12f84b0d "org.eclipse.jetty.server.Server@12f84b0d"]
minimal-webapp.server=>
```

Now navigate to [localhost:5000](http://localhost:5000/) in your browser.

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.
- Open `src/minimal_webapp/pages/splash.cljs` and replace the text `"Hello from Reagent!"` with `"Goodbye from Reagent!"`. After reloading the page in your browser, you should see the text change. You should also see additional output from your `lein cljsbuild auto`:

```
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 0.159 seconds.
```

- Open `src/minimal_webapp/server.clj` and replace the text `"Minimal Webapp"` with `"Maximal Webapp"`. Now switch to your REPL and enter `(require 'minimal-webapp.server :reload)`. After reloading the page in your browser, you should see the title of the page change.
- Open `src/minimal_webapp/server.clj`, add `(def clj-message "Clojure Message")` just after the namespace declaration, and save the file. Now enter `clj-message` at the Clojure REPL. You should get `"Clojure Message"` as output.

#### Shutting down

- Press `Control+C` to halt `lein cljsbuild auto`.
- Press `Control+D` to exit `lein repl`.

### From the command line

#### Summary

In this setup, you launch the server directly from the command line, without launching any REPLs. Building the ClojureScript is done with `lein cljsbuild`.

#### Setup

You will need two terminal sessions. In the first, do:

```
$ lein cljsbuild auto
Watching for changes before compiling ClojureScript...
2016-07-15 14:51:19.088:INFO::main: Logging initialized @11815ms
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 3.509 seconds.
```

In the second, do:

```
$ lein run -m minimal-webapp.server
2016-07-15 14:52:00.357:INFO::main: Logging initialized @6934ms
2016-07-15 14:52:00.480:INFO:oejs.Server:main: jetty-9.2.10.v20150310
2016-07-15 14:52:00.556:INFO:oejs.ServerConnector:main: Started ServerConnector@547e2c8e{HTTP/1.1}{0.0.0.0:5000}
2016-07-15 14:52:00.559:INFO:oejs.Server:main: Started @7136ms
```

Now navigate to [localhost:5000](http://localhost:5000/) in your browser.

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.
- Open `src/minimal_webapp/pages/splash.cljs` and replace the text `"Hello from Reagent!"` with `"Goodbye from Reagent!"`. After reloading the page in your browser, you should see the text change. You should also see additional output from your `lein cljsbuild auto`:

```
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 0.161 seconds.
```

### Using an uberjar

If the application were deployed to e.g. Heroku, it would run from an uberjar. To generate and run the uberjar, do:

```
$ lein uberjar
Compiling minimal-webapp.server
2016-07-15 12:14:50.824:INFO::main: Logging initialized @4008ms
Compiling ClojureScript...
2016-07-15 12:14:57.348:INFO::main: Logging initialized @6217ms
Compiling "resources/public/js/main.js" from ["src"]...
Successfully compiled "resources/public/js/main.js" in 2.163 seconds.
Created ./target/minimal-webapp-0.1.0-SNAPSHOT.jar
Created ./target/minimal-webapp-standalone.jar
$ java -jar target/minimal-webapp-standalone.jar
2016-07-15 12:15:35.950:INFO::main: Logging initialized @1344ms
2016-07-15 12:15:36.002:INFO:oejs.Server:main: jetty-9.2.z-SNAPSHOT
2016-07-15 12:15:36.035:INFO:oejs.ServerConnector:main: Started ServerConnector@180b3819{HTTP/1.1}{0.0.0.0:5000}
2016-07-15 12:15:36.035:INFO:oejs.Server:main: Started @1429ms
```

Now navigate to [localhost:5000](http://localhost:5000/) in your browser.

#### Verify that everything is working

- You should see the message "Hello from Reagent!" in your browser.

#### Shutting down

- Press `Control+C` to stop the server and exit.

## Additional notes

- Instead of launching Clojure REPLs in the terminal, you can use `C-c M-j` or `M-x cider-jack-in` in Emacs. Reloading a file is `C-c C-k`, switching namespaces is `C-c M-n`, and exiting is `C-c C-q`.

## Debugging

To remove temporary files in the `resources` and `target` directories, run `lein clean`.

## Implementation notes

The most confusing part of a Clojure project is usually the `project.clj` file. Therefore, the `project.clj` in this project is designed to be as minimal as possible. However, some of the options still warrant explanation:

```
(defproject minimal-webapp "0.1.0-SNAPSHOT"
  :description "Minimal webapp using ClojureScript, Compojure, and Reagent"

  :dependencies [;; Language
                 [org.clojure/clojure "1.8.0"]
                 [org.clojure/clojurescript "1.9.93"]

                 ;; Server
                 [compojure "1.5.1"]
```

Compojure is a wrapper around Ring, the library used to power the logic behind the web server. It includes macros that allow you to concisely specify routing logic, such as `defroutes`.

```
                 [hiccup "1.0.5"]
```

Hiccup is a small library for generating HTML from Clojure data structures. It is used on the backend of the website in order to generate the basic HTML pages that are returned to the browser, as an alternative to having separate HTML files on disk. The actual content, however, is loaded dynamically using JavaScript generated from the ClojureScript on the frontend.

```
                 [ring/ring-jetty-adapter "1.5.0"]
```

In development, Figwheel hosts the website on its own local server. However, in production (and if the application is started without Figwheel), the Jetty HTTP server is used to host the website. Ring Jetty adapter allows running a Jetty server whose routing logic is powered by Ring.

```
                 ;; Client
                 [reagent "0.5.1"]
```

Reagent is a ClojureScript wrapper around React, a JavaScript library for building interactive user interfaces. Reagent allows defining interactive HTML components in pure ClojureScript, using a similar syntax to Hiccup. After Compojure sends the user's browser a basic HTML page with a reference to the JavaScript generated from the application's ClojureScript code, the actual construction of the page is powered by Reagent.

```
                 ;; Emacs integration
                 [com.cemerick/piggieback "0.2.1"]
```

Piggieback is middleware that allows the use of a ClojureScript REPL via nREPL, which allows Emacs to integrate with a ClojureScript REPL the same way it integrates with a Clojure REPL.

```
                 [figwheel-sidecar "0.5.2"]]
```

Figwheel Sidecar provides functions that can be used to start a ClojureScript REPL from Clojure code instead of from the command line. These functions are what Emacs uses to start an integrated ClojureScript REPL.

```
  :plugins [[lein-cljsbuild "1.1.3"]
            [lein-figwheel "0.5.0-1"]]
```

The `lein-cljsbuild` and `lein-figwheel` plugins simply provide the `cljsbuild` and `figwheel` Leiningen tasks.


```
  :cljsbuild {:builds [{:id "main"
```

The `lein-cljsbuild` plugin requires an ID for each build, and will produce a warning if it is absent. The ID is reported on starting the `cljsbuild` task.

```
                        :source-paths ["src"]
```

In this project, the Clojure and ClojureScript sources are in the same directory, `src`. The backend and frontend are separated logically because they fall into different namespaces. The `lein-cljsbuild` plugin does not default to searching `src`, so the path must be specified manually.

```
                        :figwheel true
```

This inserts the client code for Figwheel while building the ClojureScript. If it is missing then Figwheel will not be able to connect to the application.

```
                        :compiler {:main "minimal-webapp.pages.splash"
```

This defines the namespace that will be initially loaded by the `main.js` script referenced by the HTML sent to the client. This namespace calls `reagent.core/render` so that actual HTML is placed on the screen.

```
                                   :output-to "resources/public/js/main.js"
```

This is the path to the main JavaScript file that will be generated by the ClojureScript compiler and that is referenced by the HTML sent to the client.

```
                                   :output-dir "resources/public/js/out"
```

This is the directory where additional JavaScript files, such as the ClojureScript language and any dependencies, are saved.

```
                                   :asset-path "js/out"}}]}
```

This is the relative URL used for references to other generated JavaScript from `main.js`. It is relative to the root of the HTTP server, which is `resources/public`.

```
  :figwheel {:ring-handler minimal-webapp.server/site
```

This tells Figwheel's web server where to get its Ring routing logic.

```
             :http-server-root "public"}
```

All of the web servers that are used to run this application serve files from the `resources/public` directory by default except for Figwheel started from a Clojure REPL (from the command line is fine). So a path (relative to the `resources` directory) has to be specified manually in order for Emacs integration to work correctly.

```
  :clean-targets ^{:protect false} ["resources" "target"]
```

This allows `lein clean` to delete the `resources` directory in addition to the `target` directory. The `:protect` metadata suppresses the error which would ordinarily be raised on adding anything other than `target` to `:clean-targets`.

```
  :uberjar-name "minimal-webapp-standalone.jar"
```

This ensures that the standalone uberjar is always generated with the same name, instead of having the current version postpended.

```
  :profiles {:uberjar {:aot :all
```

This enables ahead-of-time (AOT) compilation when compiling an uberjar, which is required at least for the `:main` namespace and which otherwise improves performance when the uberjar is deployed.

```
                       :main minimal-webapp.server
```

This specifies the location of `-main` for the uberjar, so the uberjar can be run without `-m minimal-webapp.server` being passed.

```
                       :hooks [leiningen.cljsbuild]}})
```

This builds the ClojureScript and packages it into the uberjar, which is necessary in order for the server run by the uberjar to have access to the JavaScript that powers the frontend.
