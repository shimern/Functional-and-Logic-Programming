% comb(+K, +List, -Comb) - построение сочетаний по k из элементов списка
comb(0, _, []).
comb(K, [H|T], [H|CombTail]) :- K > 0, K1 is K - 1, comb(K1, T, CombTail).
comb(K, [_|T], Comb) :- K > 0, comb(K, T, Comb).

% all_combs_up_to_k(+List, +K, -AllCombs) - построение всех сочетаний
% от 1 до k из элементов списка
all_combs_up_to_k(List, K, AllCombs) :- findall(Comb, (between(1, K, N), comb(N, List, Comb)), AllCombs).

% list_length(+list, -L, +CurL) - подсчёт длины списка
% (надо для выставления максимального k в all_combs_up_to_k)
list_length([], L, L) :- !.
list_length([_|T], L, CurL) :- NewL is CurL + 1, list_length(T, L, NewL).

% volume_sum(+List, -Sum, +CurV) - сумма объёмов
volume_sum([], Sum, Sum) :- !.
volume_sum([[V, _]|T], Sum, CurV) :- NewV is CurV + V, volume_sum(T, Sum, NewV).

% weight_sum(+List, -Sum, +CurW) - сумма веса
weight_sum([], Sum, Sum) :- !.
weight_sum([[_, W]|T], Sum, CurW) :- NewW is CurW + W, weight_sum(T, Sum, NewW).

% list_prohod1(+List, +GivenV) - предикат для работы с 1 частью задания
% (нахождение подмножества, сумма объёмов которого равна заданному объёму)
list_prohod1([], _, _) :- write("Volume cannot be reached"), fail, !.
list_prohod1([H|T], GivenV) :- volume_sum(H, Sum, 0), (Sum == GivenV -> write(H), nl, !; list_prohod1(T, GivenV)).

% list_prohod2(+List, +GivenV, -F, +CurF) - предикат для работы со 2
% частью задания
% (нахождение подмножества, сумма объёмов которого равна заданному объёму,
% а сумма весов минимальна)
list_prohod2([], _, F, F) :- !.
list_prohod2([H|T], GivenV, F, CurF) :- volume_sum(H, Sum, 0),
	(Sum == GivenV -> append(CurF, [H], NewF); append(CurF,[],NewF)), list_prohod2(T, GivenV, F, NewF).

% min_weight(+List, -Min, +CurMin, +CurMinW) - нахождение сочетания с
% минимальным весом
% CurMin - текущее подмножество с минимальным весом
% CurMinW - текущий минимум веса
min_weight([], Min, Min, _) :- !.
min_weight([H|T], Min, CurMin, CurMinW) :- weight_sum(H, Sum, 0), (Sum < CurMinW -> NewMinW is Sum, append(H,[],NewMin);
	NewMinW is CurMinW, append(CurMin,[],NewMin)), min_weight(T, Min, NewMin, NewMinW).

backpack_call(V, List) :- list_length(List, Len, 0), all_combs_up_to_k(List, Len, AllCombs),
	list_prohod1(AllCombs, V), list_prohod2(AllCombs, V, Found, []), write(Found), nl, min_weight(Found, Min, [], 10000), write(Min), nl.





% Предикат для поиска произвольного максимального паросочетания в графе
maximal_matching(Graph, Matching) :-
    findall(Edge, edge(Edge), Edges), % Получаем список всех рёбер в графе
    find_matching(Edges, [], Matching).

% Предикат для поиска паросочетания
find_matching([], Acc, Acc).
find_matching([Edge|RestEdges], Acc, Matching) :-
    edge(Edge),
    \+ member(Edge, Acc),
    \+ conflicting(Edge, Acc),
    find_matching(RestEdges, [Edge|Acc], Matching).
find_matching([Edge|RestEdges], Acc, Matching):-
    find_matching(RestEdges, Acc, Matching).

% Предикат для проверки конфликтующих рёбер
conflicting((X1, Y1), Matching) :-
    member((X2, Y2), Matching),
    (X1 = X2 ; X1 = Y2 ; Y1 = X2 ; Y1 = Y2).
% Определение рёбер в графе
edge((a, b)).
edge((b, c)).
edge((c, d)).
edge((d, e)).
edge((a, c)).
edge((b, d)).



% Предикат для чтения строк из файла
read_lines(FileName, Lines) :-
    open(FileName, read, Stream),
    read_lines_from_stream(Stream, Lines),
    close(Stream).

read_lines_from_stream(Stream, []) :-
    at_end_of_stream(Stream).

read_lines_from_stream(Stream, [Line|Rest]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, Line),
    read_lines_from_stream(Stream, Rest).

% Предикат для разделения строки на слова
split_string_on_whitespace(String, Words) :-
    split_string(String, " \t\n", "", Words).

% Предикат для удаления повторяющихся слов из списка
remove_duplicates([], []).
remove_duplicates([X|Xs], Ys) :-
    member(X, Xs),
    remove_duplicates(Xs, Ys).
remove_duplicates([X|Xs], [X|Ys]) :-
    \+ member(X, Xs),
    remove_duplicates(Xs, Ys).

% Предикат для записи списка строк в файл
write_lines_to_file(FileName, Lines) :-
    open(FileName, write, Stream),
    maplist(write_line_to_stream(Stream), Lines),
    close(Stream).

write_line_to_stream(Stream, Line) :-
    write(Stream, Line), nl(Stream).

% Основной предикат для выполнения задачи
main(InputFile, OutputFile) :-
    read_lines(InputFile, InputLines),
    maplist(split_string_on_whitespace, InputLines, WordsList),
    flatten(WordsList, AllWords),
    remove_duplicates(AllWords, UniqueWords),
    maplist(atomics_to_string(' '), UniqueWords, UniqueLines),
    write_lines_to_file(OutputFile, UniqueLines).


