part1 =: {{
	+/ (I.@(1&<:) { ]) parse_line&> }: LF splitstring y
}}

parse_line =: {{
	chunks =. _&".&.> '|' splitstring ((1&+@i.&':') }. ]) y
	card =. >{. chunks
	ours =. >{: chunks

	2 ^ -&1 +/ card e. ours
}}

