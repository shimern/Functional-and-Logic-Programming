%������� 1
%max(+X,+Y,+Z,-U) - ������� �������� XYZ
max(X,Y,Z,X):- X>Y,X>Z,!.
max(_,Y,Z,Y):- Y>Z,!.
max(_,_,Z,Z).

%factUpRec(+N,?X) - ��������� ��������� N � X ��������� �����
factUpRec(0,1):-!.
factUpRec(N,X):-N1 is N-1,factUpRec(N1,X1),X is N*X1.

%factDownRec(+N,?X) - ��������� ��������� N � X ��������� ���s�
factDownRec(N,X):-fact(0,1,N,X).
fact(N,Y,N,Y):-!.
fact(N,_,N,_):-!,fail.
fact(I,Y,N,X):-I1 is I+1, Y1 is Y*I1, fact(I1,Y1,N,X).

%numSumUp(+N,?X) - ��������� ����� ���� N � X ��������� �����
numSumUp(0,0):-!.
numSumUp(N,X):-N1 is N div 10, numSumUp(N1,X1), X is (N mod 10)+X1.

%numSumDown(+N,?X) - ��������� ����� ���� N � X ��������� ����
numSumDown(N,X):- numSum(N,0,X).
numSum(0,X,X):-!.
numSum(0,_,_):-!,fail.
numSum(N,X1,X):- N1 is N div 10,Ost is (N mod 10),TermX is X1+Ost, numSum(N1,TermX,X).


%free_num(+N)- �������� �������� ����� �� ������� �� ���������
free_num(N):- f_n(2,N),!,true.
f_n(N,N):-!.
f_n(Del,N):- DelDel is Del*Del,Ost is N mod DelDel,Ost\=0,NextDel is Del+1, f_n(NextDel,N).


% read_list(+N,-List)- �������� ������ N - ���������� ���������
read_list(N,List):- rList(0,N,List,[]).
rList(N,N,List,List):-!.
rList(CurN,N,List,NewList):-read(X), append(NewList,[X],NL), CurN1 is CurN+1, rList(CurN1,N,List,NL).

%write_list(+List) - �������� ����write_list([]):-!.
write_list([]):-!,true.
write_list([H|T]):- write(H),write(" "), write_list(T).

% sum_list_down(+List,?Summ) - �������� ���� ���� ����� ���������
% ������� �������� ����
sum_list_down(List,Summ):-s_l_d(List, 0, Summ).
s_l_d([],Summ,Summ):-!,true.
s_l_d([H|T],CurSumm, Summ):- NewCurSumm is CurSumm + H,s_l_d(T,NewCurSumm,Summ).

% sum_list_up(+List,?Summ) - �������� ���� ���� ����� ���������
% ������� �������� �����
sum_list_up([],0).
sum_list_up([H|T],Summ):- sum_list_up(T,NewSumm), Summ is NewSumm+H.

% del_el_equal_sum(+List,+Summ) - ������� ��� ��������,
%����� ���� ������� ����� Summ
delete_element(List,Summ):- del_el_equal_sum(List,Summ,[]).
del_el_equal_sum([],_,ResList):-!,write_list(ResList).
del_el_equal_sum([H|T],Summ,ResList):- numSumUp(H,X),Summ is X, del_el_equal_sum(T,Summ,ResList).
del_el_equal_sum([H|T],Summ,ResList):-append(ResList,[H],NewResList),del_el_equal_sum(T,Summ,NewResList).

%������� 2
%numMultiUp(+N,?X) - ��������� ������������ ���� N � X ��������� �����
numMultiUp(0,1):-!.
numMultiUp(N,X):-N1 is N div 10, numMultiUp(N1,X1), X is (N mod 10)*X1.

% numMultiDown(+N,?X) - ��������� ������������ ���� N � X ��������� ����
numMultiDown(N,X):-num_multi_down(1,N,X).
num_multi_down(X,0,X):-!.
num_multi_down(_,0,_):-!,fail.
num_multi_down(Mult,N,X):- N1 is N div 10,Ost is N mod 10, NewMult is Mult*Ost, num_multi_down(NewMult,N1,X).


% maxDigNotDiv3Up(+N,?X) - ����� ������������ ����� ����� �� ���������
% �� 3 ��������� �����
maxDigNotDiv3Up(0,-1):-!. %���� �������� -1, �� ������ ����� ����� �� �������
maxDigNotDiv3Up(N,X):-N1 is N div 10, maxDigNotDiv3Up(N1,X1),Digit is N mod 10, (Digit mod 3 =\=0, Digit>X1 -> X is Digit; X is X1).

% maxDigNotDiv3Down(+N,?X) - ����� ������������ ����� ����� �� ���������
% �� 3 ��������� ����
maxDigNotDiv3Down(N,X):- mDND3(N,-1,X).
mDND3(0,X,X):-!.
mDND3(0,_,_):-!,fail.
mDND3(N,X1,X):- N1 is N div 10 ,Digit is N mod 10, (Digit mod 3 =\=0, Digit>X1 -> Term is Digit, mDND3(N1,Term,X);mDND3(N1,X1,X)).

%findDelUp(+N,-X) - ����� ���� ��������� ��������� �����
findDelUp(N,X):- f_d_up(N,1,X).
f_d_up(N,N,1):-!. %���� ����� ���� ��������
f_d_up(N,X,Count):-NewDel is X+1,f_d_up(N,NewDel,NewCount),Ost is (N mod X),(Ost is 0 -> Count is NewCount+1; Count is NewCount).

%findDelDown(+N,?X) - ����� ���� ��������� ��������� ����
findDelDown(N,X):- f_d_down(N,X,1,1).%�������� � 1 ����� ���-��, ������ ��� ���� ����� ��� ����� ��������� �� �����������
f_d_down(N,X,N,X):-!. %����������� ������� ���������
f_d_down(N,_,N,_):-!,fail.%�������� �� ��, ��� ��������� ���������� ��������� �� ����� �����������
f_d_down(N,X,CurDel,Count):-Ost is (N mod CurDel),NewDel is CurDel+1, (Ost is 0 -> NewCount is Count+1,f_d_down(N,X,NewDel,NewCount); f_d_down(N,X,NewDel,Count)).



%������� 3
%������� 4 (4,21,32)
%4 ����������
%��� ������������� ������. ������� ������� ������� � ��� �������, �
% ������� ��������������� �� �������� �������� ���������
% ������������������

% sortDescIndOfList(+N) - N - ���������� ��������� � �������, ���������
% ���������� ��� ����� ���������
sortDescIndOfList(N):- read_list(N,List), s_d_ind(List,Otvet), write_list(Otvet).

% s_d_ind(+List,-Otvet) ��� ���������� ������
s_d_ind(List,Otvet):-
    create_indexes(List,[],Indexes,0), %�������� ������ �� �������� �����
    sort_down_index(Indexes,List,[],Otvet).

% create_indexes(+List,-TermInd,-Indexes,+Ind) Indexes - ���� �
% ��������� List
create_indexes([],TermIndexes,TermIndexes,_):-!.
create_indexes([_|T],TermIndexes,Indexes,Ind):-
    append(TermIndexes,[Ind],NewTermIndexes),
    NewInd is Ind+1,
    create_indexes(T,NewTermIndexes,Indexes,NewInd).


% sort_down_index(+List,-Otvet,-Res) �������� , ����������� ��������
% ������ ���������,List - ������� ���� ,Otvet - �������� ������ ��������
sort_down_index([],[],Res,Res):-!.%����� � ����� �� �������� ���������, �� �� ���������
sort_down_index(Indexes,List,Res,Otvet):-
    max_el_list(List,Mx,IndMx,-1,0,-1), %��������� ��������� �� ������� � ��� ������, � Mx,Ind - ���������
    find_start_index(El,IndMx,Indexes,0),
    append(Res,[El],NewOtvet), %��������� � ������ Ind
    del_el(List,Indexes,Mx,[],ResList,[],ResIndList), %������� ��� �������� ������ Mx � �������� � ResList ����� ����
    sort_down_index(ResIndList,ResList,NewOtvet,Otvet).

% find_start_index(-El, +IndMx,+Indexes,+Ind) - ����� ������� � �����
% ��������
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
% ������� ��� �������� ������ El � ������� �� ���������������
del_el([],[],_,CurResList,CurResList,CurResIndList,CurResIndList):-!.
del_el([H1|T1],[_|T2],El,CurResList,ResList,CurResIndList,ResIndList):- El is H1, del_el(T1,T2,El,CurResList,ResList,CurResIndList,ResIndList).
del_el([H1|T1],[H2|T2],El,CurResList,ResList,CurResIndList,ResIndList):-
    append(CurResList,[H1],NewResList),
    append(CurResIndList,[H2],NewResIndList),
    del_el(T1,T2,El,NewResList,ResList,NewResIndList,ResIndList).

% ���� �������� � ���, ��� ��� �������� ��������� �� ��������� �����
% ���������� ������� , ������� ������ �������� create_indexes, ��
% �������� ����� ������� ������ �������������, � ������ �� ����� �����
% ������ ��������� ������� ��� ������� ���������� ���������
% find_start_index ��������� ����� ��������� ������� � ������� ��������
% �� ��������� ������������� ��������


%21 ����������
%��� ������������� ������. ���������� ����� ��������, �������������
%����� ������� �������������.
%� ��� �����, ��� ��� �������� ����� ������� ��������� � �� �����

findElementsAfterFirstMax(N):- read_list(N,List), f_e_a_f_m(List,Otvet), write_list(Otvet).

%f_e_a_f_m(+List,-Otvet) - � Otvet ���������
f_e_a_f_m(List,Otvet):-  max_el_list(List,Mx,IndMx,-1,0,-1),
                         %��������� ��������� �� ������� � ��� ������, � Mx,Ind ���������
                         get_elements_after_first_max(List,IndMx,0,[],Otvet).
                         %��������� ���� ��������� �� ������� ����� ������� ��������� � Otvet ���������

% get_elements_after_first_max+List,+IndMx,+CurInd,+CurOtvet,-Otvet) - �
% Otvet ���������
get_elements_after_first_max([],_,_,CurOtvet,CurOtvet):-!.
get_elements_after_first_max([H|T],IndMx,CurInd,CurOtvet,Otvet):-
    (   CurInd> IndMx -> append(CurOtvet,[H],NewCurOtvet),
                         NewCurInd is CurInd+1,
                         get_elements_after_first_max(T,IndMx,NewCurInd,NewCurOtvet,Otvet);

                         NewCurInd is CurInd+1,
                         get_elements_after_first_max(T,IndMx,NewCurInd,CurOtvet,Otvet)).


%32 ����������
%��� ������������� ������. ����� ���������� ��� ��������� ����������.
findLocalMaxima(N):- read_list(N,List), find_local_maxima(List,Otvet), write_list(Otvet).

%find_local_maxima(+List,-Otvet)
find_local_maxima(List,Otvet):-
    check_len(List,0,Count), %����� ���������� ���������
    ( Count>2 -> f_l_m(List,0,CountMaxima); %��������� ����� ��������� ����������
                (   Count=1 -> CountMaxima is 1;
                                ( Count = 2-> existMaxXY(List,CountMaxima) %��������� ���� �� ��������
                                )
                )
    ),
    append([],[CountMaxima],Otvet).

%check_len(+List,+CurCount, -Count) - �������� ����� �����
check_len([],CurCount,CurCount):-!.
check_len([_|T],CurCount,CountEls):- NewCount is CurCount+1,check_len(T,NewCount,CountEls).

% existMaxXY (+List,-Res) - �������� ���� �� ����� ��������� �����
% ��������, ���������� true/false
existMaxXY([H1|[H2|_]],Res):- (H1\=H2 -> Res is 1; Res is 0).

% existMaxXYZ(+X,+Y,+Z) - ��������� ���� �� ����� ��� ��������,
% ���������� true/false
existMaxXYZ(X,Y,Z):- (X < Y, Y>Z).

% f_l_m(+List,+CurCount,-Count) - ��������� ��������� ���������
% ���������� � Count
f_l_m([_|[_|[]]],CurCount,CurCount):-!.
f_l_m([H1|[H2|[H3|T]]],CurCount,Count):- existMaxXYZ(H1,H2,H3),
                                         NewCurCount is CurCount+1,
                                         f_l_m([H2|[H3|T]],NewCurCount,Count).
f_l_m([_|[H2|[H3|T]]],CurCount,Count):- f_l_m([H2|[H3|T]],CurCount,Count).
