:- use_module(library(dcg/basics)).
:- use_module(library(clpfd)).

numbers([Num|Nums]) --> integer(Num), blanks, numbers(Nums).
numbers([]) --> [].

part1(File, Count) :-
    phrase_from_file(numbers(Nums), File),
    zip_adjacent(Nums, Paired),
    filter_increasing(Paired, Filtered),
    length(Filtered, Count).

part2(File, Count) :-
    phrase_from_file(numbers(Nums), File),
    window_sums(Nums, Windows),
    zip_adjacent(Windows, Paired),
    filter_increasing(Paired, Filtered),
    length(Filtered, Count).

zip_adjacent([], []).
zip_adjacent([_], []).
zip_adjacent([First, Second | Tail], Output) :-
    zip_adjacent([Second | Tail], Rest),
    Output = [[First, Second] | Rest].

filter_increasing([], []).
filter_increasing([[First, Second] | Tail], Output) :-
	First #< Second,
	filter_increasing(Tail, Other),
	Output = [[First, Second] | Other].
filter_increasing([[First, Second] | Tail], Output) :-
    First #>= Second,
    filter_increasing(Tail, Output).

window_sums([], []).
window_sums([_], []).
window_sums([_, _], []).
window_sums([First, Second, Third | Tail], Zipped) :-
    window_sums([Second, Third | Tail], Rest),
    Zipped = [First + Second + Third | Rest].
