part1 =: monad : 0
  +/parse_line"1 >LF splitstring y
)

digits =: '0123456789'

parse_line =: monad : 0
  found =. y ([-.-.) digits
  __ ". ({.found),({:found)
)
