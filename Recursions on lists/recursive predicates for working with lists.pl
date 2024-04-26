%Задание 1
%max(+X,+Y,+Z,-U) - находит максимум XYZ
max(X,Y,Z,X):- X>Y,X>Z,!.
max(_,Y,Z,Y):- Y>Z,!.
max(_,_,Z,Z).

%factUpRec(+N,?X) - вычисляет факториал N в X рекурсией вверх
factUpRec(0,1):-!.
factUpRec(N,X):-N1 is N-1,factUpRec(N1,X1),X is N*X1.

%factDownRec(+N,?X) - вычисляет факториал N в X рекурсией вниsз
factDownRec(N,X):-fact(0,1,N,X).
fact(N,Y,N,Y):-!.
fact(N,_,N,_):-!,fail.
fact(I,Y,N,X):-I1 is I+1, Y1 is Y*I1, fact(I1,Y1,N,X).

%numSumUp(+N,?X) - вычисляет сумму цифр N в X рекурсией вверх
numSumUp(0,0):-!.
numSumUp(N,X):-N1 is N div 10, numSumUp(N1,X1), X is (N mod 10)+X1.

%numSumDown(+N,?X) - вычисляет сумму цифр N в X рекурсией вниз
numSumDown(N,X):- numSum(N,0,X).
numSum(0,X,X):-!.
numSum(0,_,_):-!,fail.
numSum(N,X1,X):- N1 is N div 10,Ost is (N mod 10),TermX is X1+Ost, numSum(N1,TermX,X).


%free_num(+N)- предикат проверки числа на свободу от квадратов
free_num(N):- f_n(2,N),!,true.
f_n(N,N):-!.
f_n(Del,N):- DelDel is Del*Del,Ost is N mod DelDel,Ost\=0,NextDel is Del+1, f_n(NextDel,N).


% read_list(+N,-List)- предикат чтения N - количество элементов
read_list(N,List):- rList(0,N,List,[]).
rList(N,N,List,List):-!.
rList(CurN,N,List,NewList):-read(X), append(NewList,[X],NL), CurN1 is CurN+1, rList(CurN1,N,List,NL).

%write_list(+List) - предикат вывоwrite_list([]):-!.
write_list([]):-!,true.
write_list([H|T]):- write(H),write(" "), write_list(T).

% sum_list_down(+List,?Summ) - проверка либо сбор суммы элементов
% массива рекурсия вниз
sum_list_down(List,Summ):-s_l_d(List, 0, Summ).
s_l_d([],Summ,Summ):-!,true.
s_l_d([H|T],CurSumm, Summ):- NewCurSumm is CurSumm + H,s_l_d(T,NewCurSumm,Summ).

% sum_list_up(+List,?Summ) - проверка либо сбор суммы элементов
% массива рекурсия вверх
sum_list_up([],0).
sum_list_up([H|T],Summ):- sum_list_up(T,NewSumm), Summ is NewSumm+H.

% del_el_equal_sum(+List,+Summ) - удаляет все элементы,
%сумма цифр которых равна Summ
delete_element(List,Summ):- del_el_equal_sum(List,Summ,[]).
del_el_equal_sum([],_,ResList):-!,write_list(ResList).
del_el_equal_sum([H|T],Summ,ResList):- numSumUp(H,X),Summ is X, del_el_equal_sum(T,Summ,ResList).
del_el_equal_sum([H|T],Summ,ResList):-append(ResList,[H],NewResList),del_el_equal_sum(T,Summ,NewResList).

%Задание 2
%numMultiUp(+N,?X) - вычисляет произведение цифр N в X рекурсией вверх
numMultiUp(0,1):-!.
numMultiUp(N,X):-N1 is N div 10, numMultiUp(N1,X1), X is (N mod 10)*X1.

% numMultiDown(+N,?X) - вычисляет произведение цифр N в X рекурсией вниз
numMultiDown(N,X):-num_multi_down(1,N,X).
num_multi_down(X,0,X):-!.
num_multi_down(_,0,_):-!,fail.
num_multi_down(Mult,N,X):- N1 is N div 10,Ost is N mod 10, NewMult is Mult*Ost, num_multi_down(NewMult,N1,X).


% maxDigNotDiv3Up(+N,?X) - поиск максимальной цифры числа не делящейся
% на 3 рекурсией вверх
maxDigNotDiv3Up(0,-1):-!. %если вернется -1, то значит такой цифры не нашлось
maxDigNotDiv3Up(N,X):-N1 is N div 10, maxDigNotDiv3Up(N1,X1),Digit is N mod 10, (Digit mod 3 =\=0, Digit>X1 -> X is Digit; X is X1).

% maxDigNotDiv3Down(+N,?X) - поиск максимальной цифры числа не делящейся
% на 3 рекурсией вниз
maxDigNotDiv3Down(N,X):- mDND3(N,-1,X).
mDND3(0,X,X):-!.
mDND3(0,_,_):-!,fail.
mDND3(N,X1,X):- N1 is N div 10 ,Digit is N mod 10, (Digit mod 3 =\=0, Digit>X1 -> Term is Digit, mDND3(N1,Term,X);mDND3(N1,X1,X)).

%findDelUp(+N,-X) - поиск всех делителей рекурсией вверх
findDelUp(N,X):- f_d_up(N,1,X).
f_d_up(N,N,1):-!. %само число тоже делитель
f_d_up(N,X,Count):-NewDel is X+1,f_d_up(N,NewDel,NewCount),Ost is (N mod X),(Ost is 0 -> Count is NewCount+1; Count is NewCount).

%findDelDown(+N,?X) - поиск всех делителей рекурсией вниз
findDelDown(N,X):- f_d_down(N,X,1,1).%начинаем с 1 отчет кол-ва, потому что само число при нашей программе не засчитается
f_d_down(N,X,N,X):-!. %унифицируем конечны результат
f_d_down(N,_,N,_):-!,fail.%проверка на то, что введенное количество делителей не равно полученному
f_d_down(N,X,CurDel,Count):-Ost is (N mod CurDel),NewDel is CurDel+1, (Ost is 0 -> NewCount is Count+1,f_d_down(N,X,NewDel,NewCount); f_d_down(N,X,NewDel,Count)).



%Задание 3
%вариант 4 (4,21,32)
%4 подзадание
%Дан целочисленный массив. Вывести индексы массива в том порядке, в
% котором соответствующие им элементы образуют убывающую
% последовательность

% sortDescIndOfList(+N) - N - количество элементов в массиве, запускает
% поочередно все этапы программы
sortDescIndOfList(N):- read_list(N,List), s_d_ind(List,Otvet), write_list(Otvet).

% s_d_ind(+List,-Otvet) для корректной работы
s_d_ind(List,Otvet):-
    create_indexes(List,[],Indexes,0), %получаем список из индексов листа
    sort_down_index(Indexes,List,[],Otvet).

% create_indexes(+List,-TermInd,-Indexes,+Ind) Indexes - лист с
% индексами List
create_indexes([],TermIndexes,TermIndexes,_):-!.
create_indexes([_|T],TermIndexes,Indexes,Ind):-
    append(TermIndexes,[Ind],NewTermIndexes),
    NewInd is Ind+1,
    create_indexes(T,NewTermIndexes,Indexes,NewInd).


% sort_down_index(+List,-Otvet,-Res) предикат , реализующий основную
% логику программы,List - входной лист ,Otvet - итоговый массив индексов
sort_down_index([],[],Res,Res):-!.%когда в листе не осталось элементов, то мы закончили
sort_down_index(Indexes,List,Res,Otvet):-
    max_el_list(List,Mx,IndMx,-1,0,-1), %получение максимума из массива и его индекс, в Mx,Ind - результат
    find_start_index(El,IndMx,Indexes,0),
    append(Res,[El],NewOtvet), %добавляем в массив Ind
    del_el(List,Indexes,Mx,[],ResList,[],ResIndList), %удаляем все элементы равные Mx и получаем в ResList новый лист
    sort_down_index(ResIndList,ResList,NewOtvet,Otvet).

% find_start_index(-El, +IndMx,+Indexes,+Ind) - поиск индекса в листе
% индексов
find_start_index(El,IndMx,[H|_],IndMx):-El is H,!.
find_start_index(El,IndMx,[_|T],CurInd):- NewCurInd is CurInd+1,
                                          find_start_index(El,IndMx,T,NewCurInd).



% max_el_list(+List,-Mx,-IndMx,+CurMx,+CurIndMx,+CurInd)
max_el_list([],CurMx,CurIndMx,CurMx,CurIndMx,_):-!.
max_el_list([H|T],Mx,IndMx,CurMx,CurIndMx,CurInd):- NewCurInd is CurInd+1,(H > CurMx ->
                                         NewCurMx is H,NewCurIndMx is NewCurInd,
                                         max_el_list(T,Mx,IndMx,NewCurMx,NewCurIndMx,NewCurInd);
                                         max_el_list(T,Mx,IndMx,CurMx,CurIndMx,NewCurInd) ).

% del_el(+List,+Indexes,+El,+NewList,-ResList,+NewIndList,-ResIndList) -
% удаляет все элементы равные El и индексы им соответствующие
del_el([],[],_,CurResList,CurResList,CurResIndList,CurResIndList):-!.
del_el([H1|T1],[_|T2],El,CurResList,ResList,CurResIndList,ResIndList):- El is H1, del_el(T1,T2,El,CurResList,ResList,CurResIndList,ResIndList).
del_el([H1|T1],[H2|T2],El,CurResList,ResList,CurResIndList,ResIndList):-
    append(CurResList,[H1],NewResList),
    append(CurResIndList,[H2],NewResIndList),
    del_el(T1,T2,El,NewResList,ResList,NewResIndList,ResIndList).

% Была проблема в том, что при удалении максимума из исходного листа
% сдвигаются индексы , поэтому сделал предикат create_indexes, из
% которого будем удалять индекс максимального, и отсюда же будем брать
% индекс исходного массива для каждого найденного максимума
% find_start_index реализует поиск реального индекса в массиве индексов
% по положению максимального элемента


%21 подзадание
%Дан целочисленный массив. Необходимо найти элементы, расположенные
%после первого максимального.
%Я так понял, что все элементы после первого максимума и до конца

findElementsAfterFirstMax(N):- read_list(N,List), f_e_a_f_m(List,Otvet), write_list(Otvet).

%f_e_a_f_m(+List,-Otvet) - в Otvet результат
f_e_a_f_m(List,Otvet):-  max_el_list(List,Mx,IndMx,-1,0,-1),
                         %получение максимума из массива и его индекс, в Mx,Ind результат
                         get_elements_after_first_max(List,IndMx,0,[],Otvet).
                         %получение всех элементов из массива после первого максимума в Otvet результат

% get_elements_after_first_max+List,+IndMx,+CurInd,+CurOtvet,-Otvet) - в
% Otvet результат
get_elements_after_first_max([],_,_,CurOtvet,CurOtvet):-!.
get_elements_after_first_max([H|T],IndMx,CurInd,CurOtvet,Otvet):-
    (   CurInd> IndMx -> append(CurOtvet,[H],NewCurOtvet),
                         NewCurInd is CurInd+1,
                         get_elements_after_first_max(T,IndMx,NewCurInd,NewCurOtvet,Otvet);

                         NewCurInd is CurInd+1,
                         get_elements_after_first_max(T,IndMx,NewCurInd,CurOtvet,Otvet)).


%32 подзадание
%Дан целочисленный массив. Найти количество его локальных максимумов.
findLocalMaxima(N):- read_list(N,List), find_local_maxima(List,Otvet), write_list(Otvet).

%find_local_maxima(+List,-Otvet)
find_local_maxima(List,Otvet):-
    check_len(List,0,Count), %берем количество элементов
    ( Count>2 -> f_l_m(List,0,CountMaxima); %запускаем поиск локальных максимумов
                (   Count=1 -> CountMaxima is 1;
                                ( Count = 2-> existMaxXY(List,CountMaxima) %проверяем есть ли максимум
                                )
                )
    ),
    append([],[CountMaxima],Otvet).

%check_len(+List,+CurCount, -Count) - получает длину листа
check_len([],CurCount,CurCount):-!.
check_len([_|T],CurCount,CountEls):- NewCount is CurCount+1,check_len(T,NewCount,CountEls).

% existMaxXY (+List,-Res) - проверка есть ли среди элементов листа
% максимум, возвращает true/false
existMaxXY([H1|[H2|_]],Res):- (H1\=H2 -> Res is 1; Res is 0).

% existMaxXYZ(+X,+Y,+Z) - проверяет есть ли среди них максимум,
% возвращает true/false
existMaxXYZ(X,Y,Z):- (X < Y, Y>Z).

% f_l_m(+List,+CurCount,-Count) - получение количеста локальных
% максимумов в Count
f_l_m([_|[_|[]]],CurCount,CurCount):-!.
f_l_m([H1|[H2|[H3|T]]],CurCount,Count):- existMaxXYZ(H1,H2,H3),
                                         NewCurCount is CurCount+1,
                                         f_l_m([H2|[H3|T]],NewCurCount,Count).
f_l_m([_|[H2|[H3|T]]],CurCount,Count):- f_l_m([H2|[H3|T]],CurCount,Count).
