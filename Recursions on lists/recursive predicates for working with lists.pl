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

% del_el(+List,+Summ) - ������� ��� ��������,
%����� ���� ������� ����� Summ
delete_element(List,Summ):- del_el(List,Summ,[]).
del_el([],_,ResList):-!,write_list(ResList).
del_el([H|T],Summ,ResList):- numSumUp(H,X),Summ is X, del_el(T,Summ,ResList).
del_el([H|T],Summ,ResList):-append(ResList,[H],NewResList),del_el(T,Summ,NewResList).


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



