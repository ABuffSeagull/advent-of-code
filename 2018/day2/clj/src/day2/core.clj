(ns day2.core
  (:require clojure.set
            clojure.string)
  (:gen-class))

(defn filter-and-count-by-freq
  [n coll]
  (->> coll
       (map frequencies)
       (map clojure.set/map-invert)
       (filter #(contains? % n))
       (count)))

(defn part-one
  [coll]
  (* (filter-and-count-by-freq 2 coll) (filter-and-count-by-freq 3 coll)))

(defn get-diffs-in-strs
  [str1 str2]
  (->>
    (map #(vector %1 %2) str1 str2)
    (filter #(not= (first %) (second %)))
    count))

(defn get-same-letters
  [str1 str2]
  (->>
    (map #(vector %1 %2) str1 str2)
    (filter #(= (first %) (second %)))
    (map first)
    (clojure.string/join)))

(defn part-two
  [[head & tail]]
  (let [coll (map #(get-diffs-in-strs head %) tail)
        found (.indexOf coll 1)]
    (if (not= found -1)
      (get-same-letters head (nth tail found))
      (recur tail))))

(defn -main
  "Day 2"
  [filename]
  (->> filename
       (slurp)
       (clojure.string/split-lines)
       (part-one)
       (println)))
