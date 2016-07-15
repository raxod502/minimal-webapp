(ns minimal-webapp.server
  (:require [compojure.core :refer [defroutes GET PUT POST DELETE ANY]]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [hiccup.core :as hiccup]
            [hiccup.page :refer [include-js]]
            [ring.adapter.jetty :as jetty])
  (:gen-class))

;;;; Base HTML pages

(def main-page
  [:html
   [:head
    [:title "Minimal Webapp"]]
   [:body
    [:div#app]
    (include-js "js/main.js")]])

(def not-found-page
  [:html
   [:head
    [:title "404 Not Found"]]
   [:body
    [:h1 "Page not found"]]])

;;;; Handlers and middleware

(defroutes app
  (GET "/" [] (hiccup/html main-page))
  (route/resources "/")
  (route/not-found (hiccup/html not-found-page)))

(def site (handler/site app))

;;;; Managing the server in the REPL or from 'lein run'

(defonce ^:dynamic server nil)

(defn stop
  []
  (when server
    (.stop server)))

(defn start
  [& [port]]
  (stop)
  (alter-var-root
    #'server
    (constantly
      (jetty/run-jetty #'site
                       {:port (Long. (or port 5000))
                        :join? false}))))

(defn -main
  [& [port]]
  (start port))
