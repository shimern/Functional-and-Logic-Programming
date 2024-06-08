% ����������� �������������� �������� ������
in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).

% ��������� ���������� � ������������
arrangement_with_repetitions(_, 0, []) :- !.
arrangement_with_repetitions(AlphabetList, Length, [AlphabetItem | Arrangement]) :-
    NewLength is Length - 1,
    in_list(AlphabetList, AlphabetItem),
    arrangement_with_repetitions(AlphabetList, NewLength, Arrangement).

% ��������� ���� ������������
permutations(L, P) :-
    findall(X, permutation(L, X), P).

% �������� �������� ������� ���������� ����
check_repeats([], _, true).
check_repeats([H|T], Word, Result) :-
    (not(subset(Word, [H, H])) ->
        check_repeats(T, Word, NewResult),
        Result = NewResult
    ; Result = fail).

% �������� ��������� ���� ���� ����� 9 � ��������� ���������
generate_words(AlphabetList, Words) :-
    select(L1, AlphabetList, Rest1),
    select(L2, Rest1, Rest2),
    select(L3, Rest2, Rest3),
    Letters = [L1, L1, L2, L2, L3, L3, L3, X, Y],
    select(X, Rest3, Rest4),
    select(Y, Rest4, _),
    permutations(Letters, Words).

% ������� ��� ������ ������ ����� � ����
write_list_of_lists([]) :- !.
write_list_of_lists([H|TailListOfLists]) :-
    write_list_str(H),
    nl,
    write_list_of_lists(TailListOfLists),
    !.

write_list_str([]) :- !.
write_list_str([H|List]) :-
    write(H),
    write_list_str(List).

write_to_file(FilePath, ListOfStrings) :-
    tell(FilePath),
    write_list_of_lists(ListOfStrings),
    told,
    !.

% �������� �������� ��� ��������� � ������ ���� � ����
generate_words_to_file(FileWritePath) :-
    AlphabetList = [a, b, c, d, e, f, g, h, i],
    generate_words(AlphabetList, Words),
    write_to_file(FileWritePath, Words).

