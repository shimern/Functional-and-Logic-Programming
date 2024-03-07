jedi(luke_skywalker, 2).
jedi(cal_kestis, 2).
jedi(yoda, 2).
jedi(qui-gon_jinn, 2).
jedi(count_dooku/darth_tyranus, 1).
jedi(ben_solo/kylo_ren, 1).
jedi(anakin_skywalker/darth_vader, 1).
jedi(rey_palpatine, 1).
jedi(obi-wan_kenobi, 1).
jedi(ahsoka_tano, 1).
jedi(mace_windu, 1).
jedi(sheev_palpatine/darth_sidious, 0).
jedi(darth_maul, 0).
jedi(hego_damask_II/darth_plagueis, 0).
jedi(galen_marek/starkiller, 0).
jedi(leia_organa, 0).
jedi(qymaen_jai_sheelal/general_grievous, 0).
jedi(finn, 0).
jedi(han_solo, 0).
jedi(r2-d2, 0).
jedi(padme_amidala, 0).


force(luke_skywalker, 1).
force(cal_kestis, 1).
force(yoda, 1).
force(qui-gon_jinn, 1).
force(count_dooku/darth_tyranus, 1).
force(ben_solo/kylo_ren, 1).
force(anakin_skywalker/darth_vader, 1).
force(rey_palpatine, 1).
force(obi-wan_kenobi, 1).
force(ahsoka_tano, 1).
force(mace_windu, 1).
force(sheev_palpatine/darth_sidious, 1).
force(darth_maul, 1).
force(hego_damask_II/darth_plagueis, 1).
force(galen_marek/starkiller, 1).
force(leia_organa, 1).
force(qymaen_jai_sheelal/general_grievous, 0).
force(finn, 0).
force(han_solo, 0).
force(r2-d2, 0).
force(padme_amidala, 0).


dark(count_dooku/darth_tyranus, 2).
dark(sheev_palpatine/darth_sidious, 2).
dark(hego_damask_II/darth_plagueis, 2).
dark(qymaen_jai_sheelal/general_grievous, 2).
dark(darth_maul,2).
dark(luke_skywalker, 1).
dark(finn, 1).
dark(ben_solo/kylo_ren, 1).
dark(anakin_skywalker/darth_vader, 1).
dark(galen_marek/starkiller, 1).
dark(cal_kestis, 0).
dark(yoda, 0).
dark(qui-gon_jinn, 0).
dark(rey_palpatine, 0).
dark(obi-wan_kenobi, 0).
dark(ahsoka_tano, 0).
dark(mace_windu, 0).
dark(leia_organa, 0).
dark(han_solo, 0).
dark(r2-d2, 0).
dark(padme_amidala, 0).


order66(finn, 3).
order66(ben_solo/kylo_ren, 3).
order66(rey_palpatine, 3).
order66(galen_marek/starkiller, 3).
order66(anakin_skywalker/darth_vader, 2).
order66(obi-wan_kenobi, 2).
order66(ahsoka_tano, 2).
order66(luke_skywalker, 2).
order66(cal_kestis, 2).
order66(yoda, 2).
order66(sheev_palpatine/darth_sidious, 2).
order66(darth_maul, 2).
order66(han_solo, 2).
order66(r2-d2, 2).
order66(leia_organa, 2).
order66(qui-gon_jinn, 0).
order66(count_dooku/darth_tyranus, 0).
order66(mace_windu, 0).
order66(hego_damask_II/darth_plagueis, 0).
order66(qymaen_jai_sheelal/general_grievous, 0).
order66(padme_amidala, 0).


human(luke_skywalker, 2).
human(cal_kestis, 2).
human(qui-gon_jinn, 2).
human(count_dooku/darth_tyranus, 2).
human(ben_solo/kylo_ren, 2).
human(anakin_skywalker/darth_vader, 2).
human(rey_palpatine, 2).
human(obi-wan_kenobi, 2).
human(galen_marek/starkiller, 2).
human(leia_organa, 2).
human(finn, 2).
human(han_solo, 2).
human(padme_amidala, 2).
human(sheev_palpatine/darth_sidious, 2).
human(darth_naul, 1).
human(hego_damask_II/darth_plagueis, 1).
human(ahsoka_tano, 1).
human(yoda, 0).
human(mace_windu, 0).
human(qymaen_jai_sheelal/general_grievous, 0).
human(r2-d2, 0).


%question1(-X1)
question1(X1):-	write("Каким джедаем был?"),nl,
				write("2. Джедаем-консулом"),nl,
                                write("1. Джедаем-защитником"),nl,
				write("0. Не был джедаем"),nl,
				read(X1).
%question2(-X2)
question2(X2):-	write("Чувствителен к Силе?"),nl,
				write("1. Да"),nl,
				write("0. Нет"),nl,
				read(X2).
%question3(-X3)
question3(X3):-	write("Был на темной стороне?"),nl,
				write("2. Посмертно верен темной стороне"),nl,
                                write("1. Был некоторое время, но ушел"),nl,
				write("0. Посмертно верен светлой стороне"),nl,
				read(X3).
%question4(-X4)
question4(X4):-	write("Пережил прикал 66?"),nl,
				write("3. Родился после приказа"),nl,
				write("2. Да"),nl,
				write("1. Умер во время приказа"),nl,
				write("0. Умер до приказа"),nl,
				read(X4).
%question5(-X5)
question5(X5):-	write("Раса-человек?"),nl,
				write("2. Точно человек"),nl,
                                write("1. Человекоподобный"),nl,
				write("0. Точно не человек"),nl,
				read(X5).

% check_result(+Result) - предикат определяет длину листа всех
% подходящих элементов на текущем вопросе
check_result(Result):-length(Result, Count), (Count =:= 1 -> [Answer | _] = Result, write(Answer), fail; true).


start:-
    question1(X1),
    findall(Y, (jedi(Y, X1)), Result1),
    check_result(Result1),

    question2(X2),
    findall(Y, (jedi(Y, X1),force(Y,X2)), Result2),
    check_result(Result2),

    question3(X3),
    findall(Y, (jedi(Y, X1),force(Y,X2),dark(Y,X3)), Result3),
    check_result(Result3),

    question4(X4),
    findall(Y, (jedi(Y, X1),force(Y,X2),dark(Y,X3),order66(Y,X4)), Result4),
    check_result(Result4),

    question5(X5),
    findall(Y, (jedi(Y, X1),force(Y,X2),dark(Y,X3),order66(Y,X4),human(Y,X5)), Result5),
    check_result(Result5).









