
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

%father(+X,+Y) - ��������, �������� �� X ����� Y
father(X,Y):- parent(X,Y), man(X).

%father(+X) - ������� ���� X
father(X):- parent(Y,X), man(Y), write(Y).

%wife(+X,+Y) - �������� �������� �� X ����� Y
wife(X,Y):- parent(X,C), parent(Y,C), woman(X).

%wife(+X) - ������� ���� X
wife(X):- parent(X,C), parent(Y,C),woman(Y), write(Y).
