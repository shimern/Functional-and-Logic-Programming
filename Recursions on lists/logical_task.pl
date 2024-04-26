/*
������� � 4.
� �������, �������, ������� � ����� ��������� ������, �������, ���� � ����.
��������, ��� ���� � ������ �� � �������, ����� � ���������
��������� ����� �������� � ������� � ������, � ����� - �� ������� � ��
����.
������ ��������� ����� ����� � ������ � �������.
��� ������������ ��� �������� �� �������?
*/

%in_list(+List,+El) - �������� �� ��������� �������� � ������
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

%task/0 - ���������� ������� ���������� ������
task:-
    Containers = [_,_,_,_],
    in_list(Containers,[Liquid1,bottle]),
    in_list(Containers,[Liquid2,cup]),
    in_list(Containers,[Liquid3,jug]),
    in_list(Containers,[Liquid4,jar]),

    in_list(Containers,[milk,_]),
    in_list(Containers,[lemonade,_]),
    in_list(Containers,[kvass,_]),
    in_list(Containers,[water,_]),

    % ���� � ������ �� � �������
    Liquid1 \= water,
    Liquid1 \= milk,

    %����� � ��������� ��������� ����� �������� � ������� � ������
    %=> � ������� �� ������� � �� ����
    Liquid3 \= kvass,
    Liquid3 \= lemonade,

    %� ����� - �� ������� � �� ����
    Liquid4 \=lemonade,
    Liquid4 \= water,

    %������ ��������� ����� ����� � ������ � �������
    %=> ������ �� � ����� � �� � �������
    Liquid2 \= milk,
    Liquid4 \= milk,

    write("� ������� "),writeln(Liquid1),
    write("� ������� "),writeln(Liquid2),
    write("� ������� "),writeln(Liquid3),
    write("� ����� "),writeln(Liquid4).
