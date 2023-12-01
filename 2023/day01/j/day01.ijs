part1 =: monad : 0
    +/parse_line&> LF splitstring y
)

parse_line =. monad : 0
    {. _ ". ({.,{:) y ([-.-.) '0123456789'
)

part2 =: monad : 0
    +/parse_line2&> LF splitstring y
)

full_digits =. ' ' splitstring 'zero one two three four five six seven eight nine 0 1 2 3 4 5 6 7 8 9'
parse_line2 =. monad : 0
	bit_array_of_nums =. (E.&line)&.>full_digits
	found_numbers =. 10|I.+/&>bit_array_of_nums
	order =. >,&.>/I.&.>bit_array_of_nums
	((10&*@:{.)+{:) found_numbers /: order
)
