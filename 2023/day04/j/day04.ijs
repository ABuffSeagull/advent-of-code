part1 =: {{
	+/ (I.@(1&<:) { ]) points&> }: LF splitstring y
}}

parse_chunks =: {{ _&".&.> '|' splitstring ((1&+@i.&':') }. ]) y }}

points =: {{
	chunks =. parse_chunks y
	card =. >{. chunks
	ours =. >{: chunks

	2 ^ -&1 +/ card e. ours
}}

