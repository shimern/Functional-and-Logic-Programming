% comb(+K, +List, -Comb) - ���������� ��������� �� k �� ��������� ������
comb(0, _, []).
comb(K, [H|T], [H|CombTail]) :- K > 0, K1 is K - 1, comb(K1, T, CombTail).
comb(K, [_|T], Comb) :- K > 0, comb(K, T, Comb).

% all_combs_up_to_k(+List, +K, -AllCombs) - ���������� ���� ���������
% �� 1 �� k �� ��������� ������
all_combs_up_to_k(List, K, AllCombs) :- findall(Comb, (between(1, K, N), comb(N, List, Comb)), AllCombs).

% list_length(+list, -L, +CurL) - ������� ����� ������
% (���� ��� ����������� ������������� k � all_combs_up_to_k)
list_length([], L, L) :- !.
list_length([_|T], L, CurL) :- NewL is CurL + 1, list_length(T, L, NewL).

% volume_sum(+List, -Sum, +CurV) - ����� �������
volume_sum([], Sum, Sum) :- !.
volume_sum([[V, _]|T], Sum, CurV) :- NewV is CurV + V, volume_sum(T, Sum, NewV).

% weight_sum(+List, -Sum, +CurW) - ����� ����
weight_sum([], Sum, Sum) :- !.
weight_sum([[_, W]|T], Sum, CurW) :- NewW is CurW + W, weight_sum(T, Sum, NewW).

% list_prohod1(+List, +GivenV) - �������� ��� ������ � 1 ������ �������
% (���������� ������������, ����� ������� �������� ����� ��������� ������)
list_prohod1([], _, _) :- write("Volume cannot be reached"), fail, !.
list_prohod1([H|T], GivenV) :- volume_sum(H, Sum, 0), (Sum == GivenV -> write(H), nl, !; list_prohod1(T, GivenV)).

% list_prohod2(+List, +GivenV, -F, +CurF) - �������� ��� ������ �� 2
% ������ �������
% (���������� ������������, ����� ������� �������� ����� ��������� ������,
% � ����� ����� ����������)
list_prohod2([], _, F, F) :- !.
list_prohod2([H|T], GivenV, F, CurF) :- volume_sum(H, Sum, 0),
	(Sum == GivenV -> append(CurF, [H], NewF); append(CurF,[],NewF)), list_prohod2(T, GivenV, F, NewF).

% min_weight(+List, -Min, +CurMin, +CurMinW) - ���������� ��������� �
% ����������� �����
% CurMin - ������� ������������ � ����������� �����
% CurMinW - ������� ������� ����
min_weight([], Min, Min, _) :- !.
min_weight([H|T], Min, CurMin, CurMinW) :- weight_sum(H, Sum, 0), (Sum < CurMinW -> NewMinW is Sum, append(H,[],NewMin);
	NewMinW is CurMinW, append(CurMin,[],NewMin)), min_weight(T, Min, NewMin, NewMinW).

backpack_call(V, List) :- list_length(List, Len, 0), all_combs_up_to_k(List, Len, AllCombs),
	list_prohod1(AllCombs, V), list_prohod2(AllCombs, V, Found, []), write(Found), nl, min_weight(Found, Min, [], 10000), write(Min), nl.





% �������� ��� ������ ������������� ������������� ������������� � �����
maximal_matching(Graph, Matching) :-
    findall(Edge, edge(Edge), Edges), % �������� ������ ���� ���� � �����
    find_matching(Edges, [], Matching).

% �������� ��� ������ �������������
find_matching([], Acc, Acc).
find_matching([Edge|RestEdges], Acc, Matching) :-
    edge(Edge),
    \+ member(Edge, Acc),
    \+ conflicting(Edge, Acc),
    find_matching(RestEdges, [Edge|Acc], Matching).
find_matching([Edge|RestEdges], Acc, Matching):-
    find_matching(RestEdges, Acc, Matching).

% �������� ��� �������� ������������� ����
conflicting((X1, Y1), Matching) :-
    member((X2, Y2), Matching),
    (X1 = X2 ; X1 = Y2 ; Y1 = X2 ; Y1 = Y2).
% ����������� ���� � �����
edge((a, b)).
edge((b, c)).
edge((c, d)).
edge((d, e)).
edge((a, c)).
edge((b, d)).



% �������� ��� ������ ����� �� �����
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

% �������� ��� ���������� ������ �� �����
split_string_on_whitespace(String, Words) :-
    split_string(String, " \t\n", "", Words).

% �������� ��� �������� ������������� ���� �� ������
remove_duplicates([], []).
remove_duplicates([X|Xs], Ys) :-
    member(X, Xs),
    remove_duplicates(Xs, Ys).
remove_duplicates([X|Xs], [X|Ys]) :-
    \+ member(X, Xs),
    remove_duplicates(Xs, Ys).

% �������� ��� ������ ������ ����� � ����
write_lines_to_file(FileName, Lines) :-
    open(FileName, write, Stream),
    maplist(write_line_to_stream(Stream), Lines),
    close(Stream).

write_line_to_stream(Stream, Line) :-
    write(Stream, Line), nl(Stream).

% �������� �������� ��� ���������� ������
main(InputFile, OutputFile) :-
    read_lines(InputFile, InputLines),
    maplist(split_string_on_whitespace, InputLines, WordsList),
    flatten(WordsList, AllWords),
    remove_duplicates(AllWords, UniqueWords),
    maplist(atomics_to_string(' '), UniqueWords, UniqueLines),
    write_lines_to_file(OutputFile, UniqueLines).


