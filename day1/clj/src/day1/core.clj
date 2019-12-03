(ns day1.core
  (:require [clojure.string :as string])
  (:gen-class))

(defn part-1
  [numbers]
  (->>
   numbers
   (map #(- (Math/floor (/ % 3)) 2))
   (reduce +)))

(defn -main
  [file]
  (->>
   file
   (slurp)
   (string/split-lines)
   (map #(Integer/parseInt %))
   (part-1)
   (println)))
