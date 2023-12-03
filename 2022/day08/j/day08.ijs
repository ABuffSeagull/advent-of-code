part1 =: monad : 0
	data =. _"."0>}:LF splitstring y
	left_to_right =. visible data
	top_to_bottom =. visible&.|: data
	right_to_left =. visible&.(|."1) data
	bottom_to_top =. visible&.(|."1@:|:) data
	+/, left_to_right +. top_to_bottom +. right_to_left +. bottom_to_top
)

make_mask =: monad : 0
	(1+i.y)(#"0)1
)

visible =:( monad : 0)"1
	*./ (make_mask#y) +. y </ y
)
