:- module day4.
:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is cc_multi.

:- implementation.
:- import_module int, string, list.

main(!IO) :-
    parse_stream(Nums, !IO),
    ( if
        % find_num(Nums, Num)
        find_nums(Nums, First, Second, Third)
      then
        io.write_int(First * Second * Third, !IO),
        io.nl(!IO)
      else
        io.write_string("No number found\n", !IO)
    ).
    % io.write_list(Nums, ", ", io.write_int, !IO),
    % io.nl(!IO).

:- pred parse_stream(list(int)::out, io::di, io::uo) is det.

parse_stream(Nums, !IO) :-
    io.read_line_as_string(Result, !IO),
    ( if
        ok(Line) = Result,
        Num = string.det_to_int(strip(Line))
    then
        parse_stream(Tail, !IO),
        Nums = [Num | Tail]
    else
        Nums = []
    ).

:- pred find_num(list(int)::in, int::out) is nondet.
find_num(Nums, Num) :-
    member(Num, Nums),
    member(2020 - Num, Nums).

:- pred find_nums(list(int)::in, int::out, int::out, int::out) is nondet.
find_nums(Nums, First, Second, Third) :-
    member(First, Nums),
    member(Second, Nums),
    member(Third, Nums),
    2020 = First + Second + Third.
