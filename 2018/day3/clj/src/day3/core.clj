(ns day3.core
	(:require clojure.string)
  (:gen-class))

(defn parse-line
	"Parse the input into a map of the correct values"
	[line]
	(->> line
		(re-matcher #"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)")
		(re-find)
		(rest) ; first item is the entire string
		(map #(Integer/parseInt %))
		(zipmap [:claim :x :y :width :height])))

(defn part-2
	[coll]
	(loop [[head & tail] coll
				 fabric #{}
				 claims [true]]
		(if (some? head)
			()
			(.indexOf claims true))))

(defn -main
  [filename]
  (->> filename
	 	(slurp)
	 	(clojure.string/split-lines)
		(map parse-line)
		(part-2)))
