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

(defn total-fuel-from-mass
  "Recursively calculates all the fuel needed"
  [mass]
  (loop [remaining (fuel-from-mass mass)
         total 0]
    (if (pos? remaining)
      (recur (fuel-from-mass remaining) (+ total remaining))
      total)))

(defn part-2 [numbers]
  (->> numbers
       (map total-fuel-from-mass)
       (reduce +)))

(defn -main
  [file]
  (->> file
       (slurp)
       (string/split-lines)
       (map #(Integer/parseInt %))
       (part-2)
       (println)))
