% Определение принадлежности элемента списку
in_list([El|_], El).
in_list([_|T], El) :- in_list(T, El).

% Генерация размещения с повторениями
arrangement_with_repetitions(_, 0, []) :- !.
arrangement_with_repetitions(AlphabetList, Length, [AlphabetItem | Arrangement]) :-
    NewLength is Length - 1,
    in_list(AlphabetList, AlphabetItem),
    arrangement_with_repetitions(AlphabetList, NewLength, Arrangement).

% Генерация всех перестановок
permutations(L, P) :-
    findall(X, permutation(L, X), P).

% Предикат проверки условия повторения букв
check_repeats([], _, true).
check_repeats([H|T], Word, Result) :-
    (not(subset(Word, [H, H])) ->
        check_repeats(T, Word, NewResult),
        Result = NewResult
    ; Result = fail).

% Предикат генерации всех слов длины 9 с заданными условиями
generate_words(AlphabetList, Words) :-
    select(L1, AlphabetList, Rest1),
    select(L2, Rest1, Rest2),
    select(L3, Rest2, Rest3),
    Letters = [L1, L1, L2, L2, L3, L3, L3, X, Y],
    select(X, Rest3, Rest4),
    select(Y, Rest4, _),
    permutations(Letters, Words).

% Функция для записи списка строк в файл
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

% Основной предикат для генерации и записи слов в файл
generate_words_to_file(FileWritePath) :-
    AlphabetList = [a, b, c, d, e, f, g, h, i],
    generate_words(AlphabetList, Words),
    write_to_file(FileWritePath, Words).

