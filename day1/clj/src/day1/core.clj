(ns day1.core
  (:require [clojure.string :as string])
  (:gen-class))

(defn fuel-from-mass
  "Calculates the fuel needed for given mass"
  [mass]
  (- (Math/floor (/ mass 3)) 2))

(defn part-1 [numbers]
  (->> numbers
       (map fuel-from-mass)
       (reduce +)))

(defn part-2 [numbers])

(defn -main
  [file]
  (->> file
       (slurp)
       (string/split-lines)
       (map #(Integer/parseInt %))
       (part-1)
       (println)))
