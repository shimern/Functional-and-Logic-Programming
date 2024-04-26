/*
¬ариант є 4.
¬ бутылке, стакане, кувшине и банке наход€тс€ молоко, лимонад, квас и вода.
»звестно, что вода и молоко не в бутылке, сосуд с лимонадом
находитс€ между кувшином и сосудом с квасом, в банке - не лимонад и не
вода.
—такан находитс€ около банки и сосуда с молоком.
 ак распределены эти жидкости по сосудам?
*/

%in_list(+List,+El) - проверка на вхождение элемента в список
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

%task/0 - реализаци€ решени€ логической задачи
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

    % вода и молоко не в бутылке
    Liquid1 \= water,
    Liquid1 \= milk,

    %сосуд с лимонадом находитс€ между кувшином и сосудом с квасом
    %=> в кувшине не лимонад и не квас
    Liquid3 \= kvass,
    Liquid3 \= lemonade,

    %в банке - не лимонад и не вода
    Liquid4 \=lemonade,
    Liquid4 \= water,

    %—такан находитс€ около банки и сосуда с молоком
    %=> молоко не в банке и не в стакане
    Liquid2 \= milk,
    Liquid4 \= milk,

    write("¬ бутылке "),writeln(Liquid1),
    write("¬ стакане "),writeln(Liquid2),
    write("¬ кувшине "),writeln(Liquid3),
    write("¬ банке "),writeln(Liquid4).
