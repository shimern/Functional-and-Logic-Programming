
man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

men:- man(X),write(X), nl,fail.
women:- woman(X), write(X), nl, fail.
children(X):-parent(X,Y), write(Y), nl, fail.

%mother(+X,+Y) - �������� �������� �� X ����� Y
mother(X,Y):- parent(X,Y), woman(X).
%mother(+X) - ������� ���� X
mother(X):- parent(Y,X), woman(Y),write(Y).

%brother(?X,+Y) - �������� �������� �� X ������ Y, ������ X!=Y
brother(X,Y):- parent(P,X), parent(P,Y), man(X),man(P), not(X==Y).
%brothers(+X) - ����� ���� �������.��������� �� ������ ��������, ���� �� ���� ��������.
brothers(X):-  brother(Y,X), man(Y), write(Y), nl, fail.

%sister(?X,+Y) - �������� �������� �� X ������� Y.
sister(X,Y):- parent(P,X), parent(P,Y), woman(X),man(P), not(X==Y).

b_s(X,Y):-brother(X,Y). %b_s(?X,+Y) �������� �� ����-������ ��� ������
b_s(X,Y):-sister(X,Y). % b_s(?X,+Y) �������� �� ����-������ ��� ������

%b_s(+X)����� ���� �������, ������.
b_s(X):- b_s(Y,X), write(Y), nl, fail.


%Task 2. Create predicates father and wife

%father(?X,+Y) - ��������, �������� �� X ����� Y
father(X,Y):- parent(X,Y), man(X).

%father(+X) - ������� ���� X
father(X):- father(Y,X), write(Y).

%wife(?X,+Y) - �������� �������� �� X ����� Y
wife(X,Y):- parent(X,C), parent(Y,C), woman(X),not(X==Y).

%wife(+X) - ������� ���� X
wife(X):- wife(Y,X), write(Y).


% Task 3.
%Create predicates grand_da, grand_dats, grand_pa_and_da, aunt, aunts.

%grand_da(?X,+Y) ���������� �������� �� X ������� Y
grand_da(X,Y):- parent(Y,Z),parent(Z,X),woman(X).

%grand_dats(+X) ������� ���� ������ X
grand_dats(X):- grand_da(Y,X), write(Y),nl, fail.


%grand_pa_and_da(+X,+Y) ���������  �������� �� X � Y
%�������� � ������� ��� ��������.
grand_pa_and_da(X,Y):- grand_da(X,Y).
grand_pa_and_da(X,Y):- grand_da(Y,X).

%aunt(?X,+Y) - ��������� �������� �� X ����� Y
aunt(X,Y):-parent(Z,Y), sister(X,Z). %������ ���������

%aunts(+X) - ������� ���� ����� X
aunts(X):-aunt(Y,X), write(Y), nl, fail.
