(ns	day1.core
	(:require clojure.string)
	(:gen-class))

(defn get-input
	[filename]
	(map
	 	#(Integer/parseInt %)
		(clojure.string/split-lines
			(slurp filename))))

(defn	part-one
	"Part 1"
	[coll]
 	(reduce + coll))

(defn part-two
	"Part 2"
	[coll]
	(let [coll (cycle coll)]
		(loop [acc 0
					 curr (first coll)
					 coll (rest coll)
					 seen #{ 0 }]
			(let [acc (+ acc curr)]
				(if (contains? seen acc)
					acc
					(recur
					 	acc
					 	(first coll)
					 	(rest coll)
					 	(conj seen acc)))))))

(defn -main
	"Day 1!"
	[filename]
	(println (part-two (get-input filename))))
