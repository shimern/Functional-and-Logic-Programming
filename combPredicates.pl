
/*
    �������� �������� ��������� �������� � ������
    in_list(+List,+El) is failure
    �������� ��������� �������� �� ������
    in_list(+List,-El) is det
*/
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).



/*
    �������� ��������� ������ ���������� � �����������
    arrangement_with_repetitions(+AlphabetList,+Length,-Arrangement) is det
*/
arrangement_with_repetitions(_,0,[]):-!.
arrangement_with_repetitions(AlphabetList,Length,Arrangement):-
    NewLength is Length - 1,
    arrangement_with_repetitions(AlphabetList,NewLength,NewArrangement),
    in_list(AlphabetList, AlphabetItem),
    append(NewArrangement,[AlphabetItem],Arrangement).

/*
    �������� ��������� ������ ���������� � ������������
    arrangement_with_repetitions_list(+AlphabetList,+Length,-ArrangementList) is det
*/
arrangement_with_repetitions_list(AlphabetList,Length,ArrangementList):-
    findall(
        Arrangement,
        arrangement_with_repetitions(AlphabetList,Length,Arrangement),
        ArrangementList
    ).

/*
    �������� ��������� ������ ���������� ��� ����������
    arrangement_without_repetitions(+AlphabetList,+Length,-Arrangement) is det
    Length <= AplphabetList length
*/
arrangement_without_repetitions(AlphabetList, Length, Arrangement):-
    length(AlphabetList, AlphabetListLength),
    AlphabetListLength >= Length,
    arrangement_without_repetitions_internal(AlphabetList, Length, Arrangement).

arrangement_without_repetitions_internal(_,0,[]):-!.
arrangement_without_repetitions_internal(AlphabetList,Length,Arrangement):-
    NewLength is Length - 1,
    arrangement_without_repetitions_internal(AlphabetList,NewLength,NewArrangement),
    in_list(AlphabetList, AlphabetItem),
    not(in_list(NewArrangement, AlphabetItem)),
    append(NewArrangement,[AlphabetItem],Arrangement).

/*
    �������� ��������� ������ ���������� ��� ����������
    arrangement_with_repetitions_list(+AlphabetList,+Length,-ArrangementList) is det
*/
arrangement_without_repetitions_list(AlphabetList,Length,ArrangementList):-
    findall(
        Arrangement,
        arrangement_without_repetitions(AlphabetList,Length,Arrangement),
        ArrangementList
    ).

/*
    �������� ��������� ������ ��������� � ������������
    comb_with_repetitions(+AlphabetList.+K,-Result).
*/
comb_with_repetitions(_, 0, []):- !.
comb_with_repetitions([Letter|Alphabet], K, [Letter|PrevResult]):-
    KNew is K - 1,
    comb_with_repetitions([Letter|Alphabet], KNew, PrevResult).
comb_with_repetitions([_|Alphabet], K, PrevResult):-
    comb_with_repetitions(Alphabet, K, PrevResult).

/*
    �������� ��������� ������ ��������� � ������������
    comb_with_repetitions_list(+AlphabetList,+Length,-CombList) is det
*/
comb_with_repetitions_list(AlphabetList,Length,CombList):-
    findall(
        Comb,
        comb_with_repetitions(AlphabetList,Length,Comb),
        CombList
    ).


/*
    ����� ����� 5, � ������� ����� 2 ����� a, ��������� ����� ��
    �����������
    comb_6(+RestAlphabetList,?Word) is det
*/
comb_6(RestAlphabetList,Word):-
    arrangement_with_repetitions([a|RestAlphabetList],5,Word),
    subset(Word,[a,a]),
    \+ subset(Word,[a,a,a]),
    check_repeats(RestAlphabetList,Word,Result),
    Result.

comb_6_list(RestAlphabetList,List):-
    findall(
        Word,
        comb_6(RestAlphabetList,Word),
        ListRaw
    ),
    delete_repeats_in_matrix(ListRaw,List).

check_repeats([],_,true).
check_repeats([H|T],Word,Result):-
    (not(subset(Word,[H,H])) -> (
        check_repeats(T,Word,NewResult),
        Result = NewResult
    );(
        Result = fail
    )).


/*
    ������� ��������� ��� includes ��� filter_list
    is_not_equal(+Triple,+Double,+Xi)
*/
is_not_equal(Triple,Double,Xi):-
    Triple \= Xi,
    Double \= Xi.

/*
    ����� ����� 7, � ������� ����� 2 ����� ����������� 2 ����, �����
    ���� ����� ����������� 3 ���� ��������� ����� �� �����������.
*/
comb_9(AlphabetList,Word):-
    length(AlphabetList, AlphabetListLength),
    AlphabetListLength >= 4,
    arrangement_with_repetitions(AlphabetList,9,Word),
    in_list(AlphabetList, Triple),
    in_list(AlphabetList, Double),
    Triple \= Double,
    subset(Word,[Triple,Triple,Triple]),
    \+ subset(Word,[Triple,Triple,Triple,Triple]),
    subset(Word,[Double,Double]),
    \+ subset(Word,[Double,Double,Double]),
    include(is_not_equal(Triple,Double),AlphabetList,AlphabetListCleared),
    check_repeats(AlphabetListCleared,Word,Result),
    Result.

comb_9_list(AlphabetList,List):-
    findall(
        Word,
        comb_9(AlphabetList,Word),
        ListRaw
    ),
    delete_repeats_in_matrix(ListRaw,List).

