(ns day1.core-test
	(:require [clojure.test :refer :all]
						[day1.core :refer :all]))

(deftest part-1
	(testing "Test 1"
		(is (=
				(part-one [1, 1, 1])
				3)))
	(testing "Test 2"
		(is (=
				 (part-one [1, 1, -2])
					0)))
	(testing "Test 3"
		(is (=
					(part-one [-1, -2, -3])
					-6))))

(deftest part-2
	(testing "Test 1"
		(is (=
				 (part-two [1, -1])
					0)))
	(testing "Test 2"
		(is (=
					(part-two [3, 3, 4, -2, -4])
					10)))
	(testing "Test 3"
		(is (=
					(part-two [-6, 3, 8, 5, -6])
					5)))
	(testing "Test 4"
		(is (=
					(part-two [7, 7, -2, -7, -4])
					14))))
