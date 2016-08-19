(ns integration-test
  (:require [clojure.java.io :as io]
            [clojure.test :refer :all]))

(defn process
  [cmd & args]
  (apply println \$ cmd args)
  (let [builder (->> (cons cmd args)
                  (into-array String)
                  ProcessBuilder.)
        process (.start builder)
        printer ]
    {:in (.getOutputStream process)
     :out (.getInputStream process)
     :err (.getErrorStream process)
     :process process}))

(defn kill
  [process]
  (.destroy (:process process)))

(defn send-input
  [process input]
  (io/copy input (:in process)))

(defn wait-for-output
  [process output])
