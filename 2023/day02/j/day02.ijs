part1 =: {{
	+/1+I. parse_line&> }: LF splitstring y
}}

parse_line =: {{
	data =. (2+i.&':' y ) }. y
	*./,/ 12 13 14 >:"1 parse_chunk&> '; ' splitstring data
}}

parse_chunk =: {{
	+/parse_pull&> ', ' splitstring y
}}

colors =: ;: 'red green blue'

parse_pull =: {{
	(get_num&y)&> colors
}}

get_num =: {{
	num =. {. __ ". y
	has_color =. +./ x E. y
	num * has_color
}}

part2 =: {{
	+/parse_line2&> }: LF splitstring y
}}

parse_line2 =: {{
	data =. (2+i.&':' y ) }. y
	*/ {. |: (\:~)"1 |: parse_chunk&> '; ' splitstring data
}}
