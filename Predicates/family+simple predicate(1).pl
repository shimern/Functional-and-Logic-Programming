
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

%mother(+X,+Y) - проверка является ли X мамой Y
mother(X,Y):- parent(X,Y), woman(X).
%mother(+X) - выводит маму X
mother(X):- parent(Y,X), woman(Y),write(Y).

%brother(?X,+Y) - Проверка является ли X братом Y, причем X!=Y
brother(X,Y):- parent(P,X), parent(P,Y), man(X),man(P), not(X==Y).
%brothers(+X) - Вывод всех братьев.Проверяем по одному родителю, чтоб не было повторов.
brothers(X):-  brother(Y,X), man(Y), write(Y), nl, fail.

%sister(?X,+Y) - Проверка является ли X сестрой Y.
sister(X,Y):- parent(P,X), parent(P,Y), woman(X),man(P), not(X==Y).

b_s(X,Y):-brother(X,Y). %b_s(?X,+Y) проверка на брат-сестра или братья
b_s(X,Y):-sister(X,Y). % b_s(?X,+Y) проверка на брат-сестра или сестры

%b_s(+X)вывод всех братьев, сестер.
b_s(X):- b_s(Y,X), write(Y), nl, fail.


%Task 2. Create predicates father and wife

%father(?X,+Y) - проверка, является ли X отцом Y
father(X,Y):- parent(X,Y), man(X).

%father(+X) - вывести отца X
father(X):- father(Y,X), write(Y).

%wife(?X,+Y) - проверка является ли X женой Y
wife(X,Y):- parent(X,C), parent(Y,C), woman(X),not(X==Y).

%wife(+X) - вывести жену X
wife(X):- wife(Y,X), write(Y).


% Task 3.
%Create predicates grand_da, grand_dats, grand_pa_and_da, aunt, aunts.

%grand_da(?X,+Y) определяет является ли X внучкой Y
grand_da(X,Y):- parent(Y,Z),parent(Z,X),woman(X).

%grand_dats(+X) выводит всех внучек X
grand_dats(X):- grand_da(Y,X), write(Y),nl, fail.


%grand_pa_and_da(+X,+Y) проверяет  являются ли X и Y
%дедушкой и внучкой или наоборот.
grand_pa_and_da(X,Y):- grand_da(X,Y).
grand_pa_and_da(X,Y):- grand_da(Y,X).

%aunt(?X,+Y) - проверяет является ли X тетей Y
aunt(X,Y):-parent(Z,Y), sister(X,Z). %сестра родителей

%aunts(+X) - выводит всех тетей X
aunts(X):-aunt(Y,X), write(Y), nl, fail.
