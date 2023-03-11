:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(system)).
:- dynamic phase/1 .
:- dynamic whiteStones/1 .
:- dynamic blackStones/1 .
:- dynamic boardWhite/1 .
:- dynamic boardBlack/1 .

/**
    * @file logic.pl
    * @brief This file contains the logic of the game.
    * @details This file contains the logic of the game, such as the rules of the game.
    */
/**
    number of white stones in the bag
*/
whiteStones(12).
/**
    number of black stones in the bag
*/
blackStones(12).
/**
    number of white stones on the board
*/
boardWhite(0).
/**
    number of black stones on the board
*/
boardBlack(0).
/**
    phase of the game
*/
phase(1).

/** replace(+List, +Index, +Element, -Result)
    Replaces the element at the given index in the list with the given element.
    @param List The list to replace the element in.
    @param Index The index of the element to replace.
    @param Element The element to replace the element at the given index with.
    @param Result The list with the element replaced.
*/
replace([Y|T], 0, X, [X|T]):-
    Y \= black,
    Y \= white,
    !.
replace([H|T], I, X, [H|R]):- 
    I > -1, 
    NI is I-1, 
    replace(T, NI, X, R), 
    !.
replace(L, _, _, L).

/** replace2(+List, +Index, +Element, -Result)
    Replaces the element at the given index in the list with the given element.
    @param List The list to replace the element in.
    @param Index The index of the element to replace.
    @param Element The element to replace the element at the given index with.
    @param Result The list with the element replaced.
*/
replace2([_|T], 0, X, [X|T]):-
    !.
replace2([H|T], I, X, [H|R]):- 
    I > -1, 
    NI is I-1, 
    replace2(T, NI, X, R), 
    !.
replace2(L, _, _, L).

/** checkAdjacentRow(+RowList, +Column, +Color)
    Checks if there is a stone of the same color adjacent to the stone at the given column in the given row.
    @param RowList The list of the row to check.
    @param Column The column of the stone to check.
    @param Color The color of the stone to check.
*/
checkAdjacentRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column + 1,
    nth0(Column1, RowList, Color).

checkAdjacentRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column - 1,
    nth0(Column1, RowList, Color).
/**
    checkAdjacentColumn(+Board, +Row, +Column, +Color)
    * @brief Checks if there is a stone of the same color adjacent to the stone at the given column in the given row.
    * @param RowList The list of the row to check.
    * @param Column The column of the stone to check.
    * @param Color The color of the stone to check.
*/
checkAdjacentColumn(Board, Row, Column, Color) :-
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Color),
    Row1 is Row + 1,
    nth0(Row1, Board, RowList1),
    nth0(Column, RowList1, Color).

checkAdjacentColumn(Board, Row, Column, Color) :-
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Color),
    Row1 is Row - 1,
    nth0(Row1, Board, RowList1),
    nth0(Column, RowList1, Color).

/**
* checkRow(+RowList, +Column, +Color)
* @brief Checks if there are 3 stones of the same color in a row.
* @param RowList The list of the row to check.
* @param Column The column of the stone to check.
* @param Color The color of the stone to check.
*/

checkRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column + 1,
    nth0(Column1, RowList, Color),
    Column2 is Column + 2,
    nth0(Column2, RowList, Color),
    !.
checkRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column - 1,
    nth0(Column1, RowList, Color),
    Column2 is Column - 2,
    nth0(Column2, RowList, Color),
    Column3 is Column - 3,
    Column > 2,
    nth0(Column3, RowList, Color1),
    Color1 \= Color,
    Column < 5,
    Column4 is Column + 1,
    nth0(Column4, RowList, Color2),
    Color2 \= Color,
    !.
checkRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column - 1,
    nth0(Column1, RowList, Color),
    Column2 is Column - 2,
    nth0(Column2, RowList, Color),
    Column4 is Column + 1,
    Column < 5,
    Column < 3,
    nth0(Column4, RowList, Color2),
    Color2 \= Color,
    !.
checkRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column - 1,
    nth0(Column1, RowList, Color),
    Column2 is Column - 2,
    nth0(Column2, RowList, Color),
    Column3 is Column - 3,
    Column > 2,
    nth0(Column3, RowList, Color1),
    Color1 \= Color,
    !.
checkRow(RowList, Column, Color) :-
    nth0(Column, RowList, Color),
    Column1 is Column + 1,
    nth0(Column1, RowList, Color),
    Column2 is Column - 1,
    nth0(Column2, RowList, Color),
    !.

/**
* checkColumn(+Board, +Row, +Column, +Color)
* @brief Checks if there are 3 stones of the same color in a column.
* @param Board The board to check.
* @param Row The row of the stone to check.
* @param Column The column of the stone to check.
* @param Color The color of the stone to check.
*/

checkColumn(Board, Row, Column, Color) :-
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Color),
    Row1 is Row + 1,
    nth0(Row1, Board, RowList1),
    nth0(Column, RowList1, Color),
    Row2 is Row + 2,
    nth0(Row2, Board, RowList2),
    nth0(Column, RowList2, Color),
    Row3 is Row + 3,
    nth0(Row3, Board, RowList3),
    nth0(Column, RowList3, Color1),
    Color1 \= Color,
    Row4 is Row - 1,
    nth0(Row4, Board, RowList4),
    nth0(Column, RowList4, Color2),
    Color2 \= Color,
    !.
checkColumn(Board, Row, Column, Color) :-
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Color),
    Row1 is Row - 1,
    nth0(Row1, Board, RowList1),
    nth0(Column, RowList1, Color),
    Row2 is Row - 2,
    nth0(Row2, Board, RowList2),
    nth0(Column, RowList2, Color),
    Row3 is Row - 3,
    nth0(Row3, Board, RowList3),
    nth0(Column, RowList3, Color1),
    Color1 \= Color,
    Row4 is Row + 1,
    nth0(Row4, Board, RowList4),
    nth0(Column, RowList4, Color2),
    Color2 \= Color,
    !.
checkColumn(Board, Row, Column, Color) :-
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Color),
    Row1 is Row + 1,
    nth0(Row1, Board, RowList1),
    nth0(Column, RowList1, Color),
    Row2 is Row - 1,
    nth0(Row2, Board, RowList2),
    nth0(Column, RowList2, Color),
    Row3 is Row + 2,
    nth0(Row3, Board, RowList3),
    nth0(Column, RowList3, Color1),
    Color1 \= Color,
    Row4 is Row - 2,
    nth0(Row4, Board, RowList4),
    nth0(Column, RowList4, Color2),
    Color2 \= Color,
    !.

/**
* checkLines(+Board, +RowList, +RowNum, +Column, +Color)
* @brief Checks if there are 3 stones of the same color in a row or column.
* @param Board The board to check.
* @param RowList The row to check.
* @param RowNum The row number of the stone to check.
* @param Column The column of the stone to check.
* @param Color The color of the stone to check.
*/

checkLines(_, RowList, _, Column, Color) :-
    checkRow(RowList, Column, Color),
    !.

checkLines(Board, _, RowNum, Column, Color) :-
    checkColumn(Board, RowNum, Column, Color),
    !.

/**
* checkAdjacentBoard(+Board, +Row, +RowList, +Column, +Color)
* @brief Checks if there are 2 stones adjacent to each other of the same color in a row or column of the board.
* @param Board The board to check.
* @param Row The row of the stone to check.
* @param RowList The row to check.
* @param Column The column of the stone to check.
* @param Color The color of the stone to check.
*/
checkAdjacentBoard(_,_,RowList,Column,Color) :-
    checkAdjacentRow(RowList,Column,Color).

checkAdjacentBoard(Board,Row,_,Column,Color) :-
    checkAdjacentColumn(Board,Row,Column,Color).

/**
* checkPlayer1Move(+RowList, +NewRowList, +Board, +Column, +Row, +Color, +NewBoard, +WhiteSpots, +BlackSpots, +LevelWhite, +LevelBlack)
* @brief Checks if the move made by player 1 is valid in the 1st phase of the game.
* @param RowList The old row before the move.
* @param NewRowList The new row after the move to check.
* @param Board The old board before the move.
* @param Column The column of the stone to check.
* @param Row The row of the stone to check.
* @param Color The color of the stone to check.
* @param NewBoard The new board to check after the move.
* @param WhiteSpots The number of valid white spots on the board.
* @param BlackSpots The number of valid black spots on the board.
* @param LevelWhite The level of the white player (0 if human, 1 if easy, 2 if hard).
* @param LevelBlack The level of the black player (0 if human, 1 if easy, 2 if hard).
*/


checkPlayer1Move(RowList, NewRowList, Board, _, _, _, _, WhiteSpots, BlackSpots, LevelWhite, LevelBlack) :-
    RowList = NewRowList,
    write('[Player 1] Invalid move!'),
    nl,
    playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).

checkPlayer1Move(RowList, NewRowList, Board, Column, Row, Color, NewBoard, WhiteSpots, BlackSpots, LevelWhite, LevelBlack) :-
    RowList \= NewRowList,
    checkAdjacentBoard(NewBoard, Row, NewRowList, Column, Color),
    write('[Player 1] Invalid move! Cannot place two white stones next to each other!'),
    nl,
    playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).

checkPlayer1Move(_, _, _, _, _, _, _, _, _, _, _) :-
    write('[Player 1] Valid move!'),
    nl,
    !.

/**
* checkPlayer2Move(+RowList, +NewRowList, +Board, +Column, +Row, +Color, +NewBoard, +WhiteSpots, +BlackSpots, +LevelWhite, +LevelBlack)
* @brief Checks if the move made by player 2 is valid in the 1st phase of the game.
* @param RowList The old row before the move.
* @param NewRowList The new row after the move to check.
* @param Board The old board before the move.
* @param Column The column of the stone to check.
* @param Row The row of the stone to check.
* @param Color The color of the stone to check.
* @param NewBoard The new board to check after the move.
* @param WhiteSpots The number of valid white spots on the board.
* @param BlackSpots The number of valid black spots on the board.
* @param LevelWhite The level of the white player (0 if human, 1 if easy, 2 if hard).
* @param LevelBlack The level of the black player (0 if human, 1 if easy, 2 if hard).
*/


checkPlayer2Move(RowList, NewRowList, Board, _, _, _, _, WhiteSpots, BlackSpots, LevelWhite, LevelBlack) :-
    RowList = NewRowList,
    write('[Player 2] Invalid move!'),
    nl,
    playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).

checkPlayer2Move(RowList, NewRowList, Board, Column, Row, Color, NewBoard, WhiteSpots, BlackSpots, LevelWhite, LevelBlack) :-
    RowList \= NewRowList,
    checkAdjacentBoard(NewBoard, Row, NewRowList, Column, Color),
    write('[Player 2] Invalid move! Cannot place two black stones next to each other!'),
    nl,
    playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).

checkPlayer2Move(_, _, _, _, _, _, _, _, _, _, _) :-
    write('[Player 2] Valid move!'),
    nl,
    !.
/**
* checkInside(+Elem, +Board)
* @brief Checks if an element is inside a board.
* @param Elem The element to check.
* @param Board The board to check.
*/

checkInside(Elem, Board):-
    Row is 0,
    nth0(Row, Board, RowList),
    member(Elem, RowList),
    !.
checkInside(Elem, Board):-
    Row is 1,
    nth0(Row, Board, RowList),
    member(Elem, RowList),
    !.
checkInside(Elem, Board):-
    Row is 2,
    nth0(Row, Board, RowList),
    member(Elem, RowList),
    !.
checkInside(Elem, Board):-
    Row is 3,
    nth0(Row, Board, RowList),
    member(Elem, RowList),
    !.
checkInside(Elem, Board):-
    Row is 4,
    nth0(Row, Board, RowList),
    member(Elem, RowList),
    !.

/**
* check_double(+Elem, +List, +Previous, -New)
* @brief Checks if an element is inside a list and if it is, adds it to the previous list.
* @param Elem The element to check.
* @param List The list to check.
* @param Previous The previous list.
* @param New The new list.
*/

check_double(Elem, List, Previous, New):-
    member(Elem, List),
    appendif(Elem, Previous, New).
check_double(Elem, List, Previous, New):-
    \+ member(Elem, List),
    New = Previous.

/**
* computerRemoveSomething(+Board, +All_Stones, -Coord)
* @brief Tries to break a 2-in-a-line of the opponent and if it can't, removes a random stone.
* @param Board The board to check.
* @param All_Stones The list of all the opponent's stones on the board.
* @param Coord The coordinate of the stone to remove.
*/

computerRemoveSomething(Board, All_Stones, Coord):- % if there is a clever move, remove it
    computerRemoveClever(Board, All_Stones, [], Coords),
    length(Coords, Length),
    Length > 0,
    random(0, Length, Index),
    nth0(Index, Coords, Coord).
computerRemoveSomething(_, All_Stones, Coord):- % if no clever move, remove random
    length(All_Stones, Length),
    random(0, Length, Index),
    nth0(Index, All_Stones, Coord).

/**
* computerRemoveClever(+Board, +All_Stones, +Previous, -Coords)
* @brief Tries to break a 2-in-a-line of the opponent.
* @param Board The board to check.
* @param All_Stones The list of all the opponent's stones on the board.
* @param Previous The previous list of coordinates.
* @param Coords The list of all possible coordinates of stones to remove.
*/

computerRemoveClever(_, [], Previous, Coords):-
    Coords = Previous.
computerRemoveClever(Board, [H|T], Previous, Coords):-
    nth0(0, H, X),
    nth0(1, H, Y),
    NewX is X - 1,
    NewY is Y - 1,
    NewX1 is X + 1,
    NewY1 is Y + 1,
    check_double([NewX, Y], T, Previous, New),
    check_double([NewX1, Y], T, New, New1),
    check_double([X, NewY], T, New1, New2),
    check_double([X, NewY1], T, New2, New3),
    computerRemoveClever(Board, T, New3, Coords).

/**
* checkStone(+Stone, +Checker)
* @brief Checks if a stone is equal to a checker.
* @param Stone The stone to check.
* @param Checker The checker to check.
*/

checkStone(Stone, Checker):-
    Stone = Checker.

/**
* checkRemove(+Board, +RowList, +RowNum, +Column, +Color, +White, +Black, +LevelWhite, +LevelBlack)
* @brief Checks if a move made by a player removes an oponent stone.
* @param Board The board to check.
* @param RowList The row to check.
* @param RowNum The row number to check.
* @param Column The column to check.
* @param Color The color of the stone to check.
* @param White The number of white stones on the board.
* @param Black The number of black stones on the board.
* @param LevelWhite The level of the white player (0 if human, 1 if easy, 2 if hard).
* @param LevelBlack The level of the black player (0 if human, 1 if easy, 2 if hard).
*/

checkRemove(Board, RowList, RowNum, Column, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    LevelWhite = 0,
    checkLines(Board, RowList, RowNum, Column, Color),
    removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack),
    !.
checkRemove(Board, RowList, RowNum, Column, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    LevelBlack = 0,
    checkLines(Board, RowList, RowNum, Column, Color),
    removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack),
    !.
checkRemove(Board, RowList, RowNum, Column, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    LevelWhite \= 0,
    checkLines(Board, RowList, RowNum, Column, Color),
    computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack),
    !.
checkRemove(Board, RowList, RowNum, Column, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    LevelBlack \= 0,
    checkLines(Board, RowList, RowNum, Column, Color),
    computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack),
    !.
checkRemove(Board, _, _, _, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    playSecondPhase2(Board, White, Black, LevelWhite, LevelBlack),
    !.
checkRemove(Board, _, _, _, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    playSecondPhase1(Board, White, Black, LevelWhite, LevelBlack),
    !.

/**
* computerRemove(+Board, +Color, +White, +Black, +LevelWhite, +LevelBlack)
* @brief Removes a stone from the board when 3 or more stones are in a line and the player is the computer.
* @param Board The board to check.
* @param Color The color of the stone to check.
* @param White The number of white stones on the board.
* @param Black The number of black stones on the board.
* @param LevelWhite The level of the white player (0 if human, 1 if easy, 2 if hard).
* @param LevelBlack The level of the black player (0 if human, 1 if easy, 2 if hard).
*/

computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    LevelWhite = 1,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, black)), All_Stones),
    randomMove(Board, All_Stones, Color, LevelWhite, Coord),
    nth0(0, Coord, Row),
    nth0(1, Coord, Column),
    pos(Row, L),
    nth0(Row, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, Row, NewRowList, NewBoard),
    nl,
    write('Computer removed a black stone from row: '),
    write(L),
    write(' and column: '),
    write(Column),
    nl,
    NewBlack is Black - 1,
    retract(boardBlack(Black)),
    assert(boardBlack(NewBlack)),
    playSecondPhase2(NewBoard, White, NewBlack, LevelWhite, LevelBlack),
    !.
computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    LevelWhite = 2,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, black)), All_Stones),
    computerRemoveSomething(Board, All_Stones, Coord),
    nth0(0, Coord, Row),
    nth0(1, Coord, Column),
    pos(Row, L),
    nth0(Row, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, Row, NewRowList, NewBoard),
    nl,
    write('Computer removed a black stone from row: '),
    write(L),
    write(' and column: '),
    write(Column),
    nl,
    NewBlack is Black - 1,
    retract(boardWhite(Black)),
    assert(boardWhite(NewBlack)),
    playSecondPhase2(NewBoard, White, NewBlack, LevelWhite, LevelBlack),
    !.
computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    LevelBlack = 1,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, white)), All_Stones),
    randomMove(Board, All_Stones, Color, LevelBlack, Coord),
    nth0(0, Coord, Row),
    nth0(1, Coord, Column),
    pos(Row, L),
    nth0(Row, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, Row, NewRowList, NewBoard),
    nl,
    write('Computer removed a white stone from row: '),
    write(L),
    write(' and column: '),
    write(Column),
    nl,
    NewWhite is White - 1,
    retract(boardWhite(White)),
    assert(boardWhite(NewWhite)),
    playSecondPhase1(NewBoard, NewWhite, Black, LevelWhite, LevelBlack),
    !.
computerRemove(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    LevelBlack = 2,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, white)), All_Stones),
    computerRemoveSomething(Board, All_Stones, Coord),
    nth0(0, Coord, Row),
    nth0(1, Coord, Column),
    pos(Row, L),
    nth0(Row, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, Row, NewRowList, NewBoard),
    nl,
    write('Computer removed a white stone from row: '),
    write(L),
    write(' and column: '),
    write(Column),
    nl,
    NewWhite is White - 1,
    retract(boardWhite(White)),
    assert(boardWhite(NewWhite)),
    playSecondPhase1(NewBoard, NewWhite, Black, LevelWhite, LevelBlack),
    !.
/**
* removeOponent(+Board, +Color, +White, +Black, +LevelWhite, +LevelBlack)
* @brief Removes a stone from the board when 3 or more stones are in a line and the player is the human.
* @param Board The board to check.
* @param Color The color of the stone to check.
* @param White The number of white stones on the board.
* @param Black The number of black stones on the board.
* @param LevelWhite The level of the white player (0 if human, 1 if easy, 2 if hard).
* @param LevelBlack The level of the black player (0 if human, 1 if easy, 2 if hard).
*/

removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = white,
    displayGame(Board),
    write('Choose a column of an opponent\'s piece to remove (0-5): '),
    read(Column),
    write('Choose a row of an opponent\'s piece to remove (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    nth0(Column, RowList, Stone),
    checkStone(Stone, black),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    nl,
    write('Removed opponent\'s piece!'),
    nl,
    NewBlack is Black - 1,
    retract(boardBlack(Black)),
    assert(boardBlack(NewBlack)),
    playSecondPhase2(NewBoard, White, NewBlack, LevelWhite, LevelBlack),
    !.
removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack):-
    Color = black,
    displayGame(Board),
    write('Choose a column of an opponent\'s piece to remove (0-5): '),
    read(Column),
    write('Choose a row of an opponent\'s piece to remove (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    nth0(Column, RowList, Stone),
    checkStone(Stone, white),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    nl,
    write('Removed opponent\'s piece!'),
    nl,
    NewWhite is White - 1,
    retract(boardWhite(White)),
    assert(boardWhite(NewWhite)),
    playSecondPhase1(NewBoard, NewWhite, Black, LevelWhite, LevelBlack),
    !.
removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack):-
    write('[RemoveOpponent] Invalid move!'),
    nl,
    removeOponent(Board, Color, White, Black, LevelWhite, LevelBlack).

/**
* changeRow(+Row, +Col, -NewRow)
* @brief Changes a row of the board.
* @param Row The row to change.
* @param Col The column to change.
* @param NewRow The new row.
*/
changeRow(Row, Col, NewRow):-
    Col1 is Col - 1,
    Col2 is Col + 1,
    replace(Row, Col1, 1, NewRow1),
    replace(NewRow1, Col2, 1, NewRow2),
    replace(NewRow2, Col, 1, NewRow).

/**
* changeSpots(+Spots, +Column, +Row, -NewSpots)
* @brief Changes the valid white or black spots of the board.
* @param Spots The spots to change.
* @param Column The column to change.
* @param Row The row to change.
* @param NewSpots The new valid spots.
*/
changeSpots(Spots, Column, Row, NewSpots):-
    Row1 is Row - 1,
    Row2 is Row + 1,
    Row1 >= 0,
    Row2 =< 4,
    !,
    nth0(Row, Spots, RowList),
    changeRow(RowList, Column, NewRowList),
    replace(Spots, Row, NewRowList, NewSpots1),
    nth0(Row1, NewSpots1, RowList1),
    replace(RowList1, Column, 1, NewRowList1),
    replace(NewSpots1, Row1, NewRowList1, NewSpots2),
    nth0(Row2, NewSpots2, RowList2),
    replace(RowList2, Column, 1, NewRowList2),
    replace(NewSpots2, Row2, NewRowList2, NewSpots).
changeSpots(Spots, Column, Row, NewSpots):-
    Row1 is Row - 1,
    Row1 >= 0,
    !,
    nth0(Row, Spots, RowList),
    changeRow(RowList, Column, NewRowList),
    replace(Spots, Row, NewRowList, NewSpots1),
    nth0(Row1, NewSpots1, RowList1),
    replace(RowList1, Column, 1, NewRowList1),
    replace(NewSpots1, Row1, NewRowList1, NewSpots).
changeSpots(Spots, Column, Row, NewSpots):-
    Row2 is Row + 1,
    Row2 =< 4,
    !,
    nth0(Row, Spots, RowList),
    changeRow(RowList, Column, NewRowList),
    replace(Spots, Row, NewRowList, NewSpots1),
    nth0(Row2, NewSpots1, RowList2),
    replace(RowList2, Column, 1, NewRowList2),
    replace(NewSpots1, Row2, NewRowList2, NewSpots).
/*
* checkAdjacentMove(+Col, +Row, +NewCol, +NewRow)
* @brief Predicate that checks if a move is adjacent to another stone
* @details This predicate checks if a move is adjacent to another stone, it's important for the
* second phase of the game where the players can only move their stones to adjacent positions
* @param Col The column of the stone to move
* @param Row The row of the stone to move
* @param NewCol The column of the new position
* @param NewRow The row of the new position
*/
checkAdjacentMove(Col, Row, NewCol, NewRow):-
    Col = NewCol,
    NewRow1 is NewRow + 1,
    Row = NewRow1,
    !.
checkAdjacentMove(Col, Row, NewCol, NewRow):-
    Col = NewCol,
    NewRow1 is NewRow - 1,
    Row = NewRow1,
    !.
checkAdjacentMove(Col, Row, NewCol, NewRow):-
    Row = NewRow,
    NewCol1 is NewCol + 1,
    Col = NewCol1,
    !.
checkAdjacentMove(Col, Row, NewCol, NewRow):-
    Row = NewRow,
    NewCol1 is NewCol - 1,
    Col = NewCol1,
    !.

/**
* phase2_check_valid(+Board, +X, +Y, +Previous, -New)
* @brief Predicate that checks if a move is valid in the second phase of the game
* @param Board The board
* @param X The column of the move
* @param Y The row of the move
* @param Previous The list of the previous valid moves from the previous recursive call
* @param New The list of the new valid moves
*/

phase2_check_valid(Board, X, Y, Previous, New):-
    X >= 0,
    X =< 4,
    Y >= 0,
    Y =< 5,
    nth0(X, Board, Row),
    nth0(Y, Row, empty),
    \+ member([X, Y], Previous), % not member ( \+ = not)
    append(Previous, [[X, Y]], New),
    !.
phase2_check_valid(_, _, _, Previous, New):-
    New = Previous.

/**
* phase2_valid_moves(+Board, +Coord, -All_Valid)
* @brief Predicate that gets all the valid moves of a player in the second phase of the game
* @param Board The board
* @param Coord The list of the player's stones
* @param All_Valid The list of all the valid moves
*/

phase2_valid_moves(Board, Coord, All_Valid):-
    nth0(0, Coord, X),
    nth0(1, Coord, Y),
    NewX is X - 1,
    NewY is Y - 1,
    NewX1 is X + 1,
    NewY1 is Y + 1,
    phase2_check_valid(Board, NewX, Y, [], New_Prev),
    phase2_check_valid(Board, NewX1, Y, New_Prev, New_Prev1),
    phase2_check_valid(Board, X, NewY, New_Prev1, New_Prev2),
    phase2_check_valid(Board, X, NewY1, New_Prev2, New_Prev3),
    All_Valid = New_Prev3.

/** 
* valid_moves(+Board, +Coord, +Color, -Valid)
* @brief Predicate that gets all the valid moves of a player depending on the phase of the game
* @param Board The board
* @param Coord The list of the player's stones
* @param Color The color of the player
* @param Valid The list of all the valid moves
*/

valid_moves(Board, _,_, Valid):-
    phase(Phase),
    Phase = 1,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, empty)), Valid),
    nl.

/**
* check_valid(+Board, +X, +Y, +Previous, -New)
* @brief Predicate that checks if a move is valid
* @param Board The board
* @param X The column of the move
* @param Y The row of the move
* @param Previous The list of the previous valid moves from the previous recursive call
* @param New The list of the new valid moves
*/

check_valid(Board, X, Y, L, New):-
    X >= 0,
    X =< 4,
    Y >= 0,
    Y =< 5,
    nth0(X, Board, Row),
    nth0(Y, Row, empty),
    \+ member([X, Y], L), % not member ( \+ = not)
    append([[X, Y]], L, New),
    !.
check_valid(_, _, _, L, New):-
    New = L.

/**
* game_over(+Board)
* @brief Predicate that checks if the game is over
* @param Board The board
*/

game_over(Board):-
    phase(Phase),
    Phase = 2,
    boardWhite(White),
    White = 0,
    !,
    displayGame(Board),
    write('Game over!'),
    nl,
    write('Black wins!'),
    nl.
game_over(Board):-
    phase(Phase),
    Phase = 2,
    boardBlack(Black),
    Black = 0,
    !,
    displayGame(Board),
    write('Game over!'),
    nl,
    write('White wins!'),
    nl.

/**
* choose_move(+Board, +Valid, +Color, +Level, -Move)
* @brief Predicate that chooses a move depending on the level of the game
* @param Board The board
* @param Valid The list of all the valid moves
* @param Color The color of the player
* @param Level The level of the game
* @param Move The move chosen
*/

choose_move(_,Valid, _, Level, Move):-
    phase(Phase),
    Phase = 1,
    Level = 1,
    !,
    length(Valid, Length),
    random(0, Length, Index),
    nth0(Index, Valid, Move).
choose_move(Board, [Move|_], _, Level, Move):-
    phase(Phase),
    Phase = 1,
    Level = 2,
    nth0(0, Move, L),
    nth0(1, Move, Column),
    nth0(L, Board, Row),
    checkAdjacentColumn(Board,L,Column,white); checkAdjacentColumn(Board,L,Column,black) ; 
    checkAdjacentRow(Row,Column,white); checkAdjacentRow(Row,Column,black),
    !.
choose_move(Board, [_|T], _, Level, Move):-
    phase(Phase),
    Phase = 1,
    Level = 2,
    choose_move(Board, T, _, Level, Move).
choose_move(_, Valid, _, Level, Move):-
    phase(Phase),
    Phase = 1,
    Level = 2,
    !,
    length(Valid, Length),
    random(0, Length, Index),
    nth0(Index, Valid, Move).

/**
* appendif(+Element, +Previous, -List)
* @brief Append to list if element isn't already in it
* @param Element The element to append
* @param Previous List to check if item already inside
* @param List Returned list with new element
*/

appendif(Element, Previous, List):-
    \+ member(Element, Previous),
    append([Element], Previous, List).
appendif(_, Previous, List):-
    List = Previous.

/**
* new_check_valid(+Board, +X, +Y, +OldX, +OldY, +Previous, -New)
* @brief Predicate that checks if a move is valid
* @param Board The board
* @param X The column of where to move to
* @param Y The row of where to move to
* @param OldX The column of the intial position
* @param OldY The row of the initial position
* @param Previous The list of the previous valid moves from the previous recursive call
* @param New The list of the new valid moves
*/

new_check_valid(Board, X, Y, OldX, OldY, L, New):-
    X >= 0,
    X =< 4,
    Y >= 0,
    Y =< 5,
    nth0(X, Board, Row),
    nth0(Y, Row, empty),
    \+ member([X, Y], L), % not member ( \+ = not)
    append([[[OldX, OldY], [X, Y]]], L, New),
    !.
new_check_valid(_, _, _, _, _, L, New):-
    New = L.

/**
* rand_move(+Board, +All_Stones, +Valid_List, -Move)
* @brief Predicate that creates a list of all possible moves
* @param Board The board
* @param All_Stones The list of all the stones
* @param Valid_List The list of all the valid moves
* @param Move The list of possible moves
*/

rand_move(_, [], Valid_List, Move):- 
    Move = Valid_List.
rand_move(Board, [H|T], Valid_List, Move):-
    nth0(0, H, X),
    nth0(1, H, Y),
    NewX is X - 1,
    NewY is Y - 1,
    NewX1 is X + 1,
    NewY1 is Y + 1,
    new_check_valid(Board, NewX1, Y, X, Y, Valid_List, New),
    new_check_valid(Board, NewX, Y, X, Y, New, New1),
    new_check_valid(Board, X, NewY1, X, Y, New1, New2),
    new_check_valid(Board, X, NewY, X, Y, New2, New3),
    rand_move(Board, T, New3, Move).


/**
* check_pair(+Board, +List, +Color, +Previous, -Coords)
* @brief Predicate that adds coordinate of location where if a stone would be there, it would be 3 in a row
* @param Board Board with current pieces
* @param List ([H|T]) The list of the player's stones
* @param Color The color of the player
* @param Previous The list of the coordinates of the player's stones where there are 2 stones of the same color
* @param Coords The updated list of Previous
*/

check_pair(_, [], _, Previous, Coords):-
    Coords = Previous.
check_pair(Board, [H|T], Color, Previous, Coords):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column - 1,
    C2 is Column + 1,
    C1 >= 0,
    C2 =< 5,
    nth0(C1, RowList, Color),
    nth0(C2, RowList, empty),
    appendif([Row, C2], Previous, New1),
    check_pair(Board, T, Color, New1, Coords).
check_pair(Board, [H|T], Color, Previous, Coords):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column - 1,
    C2 is Column + 1,
    C1 >= 0,
    C2 =< 5,
    nth0(C2, RowList, Color),
    nth0(C1, RowList, empty),
    appendif([Row, C1], Previous, New1),
    check_pair(Board, T, Color, New1, Coords).
check_pair(Board, [H|T], Color, Previous, Coords):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row - 1,
    R2 is Row + 1,
    R1 >= 0,
    R2 =< 4,
    nth0(R1, Board, RowList1),
    nth0(R2, Board, RowList2),
    nth0(Column, RowList1, Color),
    nth0(Column, RowList2, empty),
    appendif([R2, Column], Previous, New1),
    check_pair(Board, T, Color, New1, Coords).
check_pair(Board, [H|T], Color, Previous, Coords):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row - 1,
    R2 is Row + 1,
    R1 >= 0,
    R2 =< 4,
    nth0(R1, Board, RowList1),
    nth0(R2, Board, RowList2),
    nth0(Column, RowList1, empty),
    nth0(Column, RowList2, Color),
    appendif([R1, Column], Previous, New1),
    check_pair(Board, T, Color, New1, Coords).
check_pair(Board, [_|T], Color, Previous, Coords):-
    check_pair(Board, T, Color, Previous, Coords).

/**
* check_valid2(+Board, +X, +Y, +Previous, -L)
* @brief Predicate that checks if a move is valid
* @param Board The board
* @param X The row of the move
* @param Y The column of the move
* @param Previous The list of the previous valid moves from the previous recursive call
* @param L The list of the new valid moves
*/

check_valid2(Board, X, Y, Color, _):-
    X >= 0,
    X =< 4,
    Y >= 0,
    Y =< 5,
    nth0(X, Board, Row),
    \+ nth0(Y, Row, Color).

/**
* check_possible(+Board, +List, +Color, +Previous, -New)
* @brief Predicate that creates a list of valid moves to make 3 in a row
* @param Board The board
* @param List List with all coordinates from check_pair function
* @param Color The color of the stone to make 3 in a row
* @param Previous The list of the previous valid moves from the previous recursive call
* @param New The list of the new valid moves
*/

check_possible(_, [], _, Previous, New):-
    New = Previous.
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column - 1,
    C2 is Column - 2,
    C2 < 0,
    nth0(C1, RowList, Color),
    append([[[Row, C1], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column - 1,
    C2 is Column - 2,
    C2 >= 0,
    nth0(C1, RowList, Color),
    check_valid2(Board, Row, C2, Color, Previous),
    append([[[Row, C1], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column + 1,
    C2 is Column + 2,
    C2 > 5,
    nth0(C1, RowList, Color),
    append([[[Row, C1], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(Row, Board, RowList),
    nth0(1, H, Column),
    C1 is Column + 1,
    C2 is Column + 2,
    C2 =< 5,
    nth0(C1, RowList, Color),
    check_valid2(Board, Row, C2, Color, Previous),
    append([[[Row, C1], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row - 1,
    R2 is Row - 2,
    R2 < 0,
    nth0(R1, Board, RowList),
    nth0(Column, RowList, Color),
    append([[[R1, Column], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row - 1,
    R2 is Row - 2,
    R2 >= 0,
    nth0(R1, Board, RowList),
    nth0(Column, RowList, Color),
    check_valid2(Board, R2, Column, Color, Previous),
    append([[[R1, Column], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row + 1,
    R2 is Row + 2,
    R2 > 4,
    nth0(R1, Board, RowList),
    nth0(Column, RowList, Color),
    append([[[R1, Column], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [H|T], Color, Previous, New):-
    nth0(0, H, Row),
    nth0(1, H, Column),
    R1 is Row - 1,
    R2 is Row - 2,
    R2 =< 4,
    nth0(R1, Board, RowList),
    nth0(Column, RowList, Color),
    check_valid2(Board, R2, Column, Color, Previous),
    append([[[R1, Column], [Row, Column]]], Previous, New1),
    check_possible(Board, T, Color, New1, New).
check_possible(Board, [_|T], Color, Previous, New):-
    check_possible(Board, T, Color, Previous, New).

/**
* randomMove(+Board, +Valid, +Color, +Level, -Move)
* @brief Predicate that chooses a random move if level is easy and chooses a move that tries to make a line of 3 if level is hard
* @param Board The board
* @param Valid The list of all the valid moves
* @param Color The color of the player
* @param Level The level of the game
* @param Move The move chosen
*/

randomMove(_, Valid, _, Level, Move):-
    Level = 1,
    length(Valid, Length),
    random(0, Length, Index),
    nth0(Index, Valid, Move).
randomMove(Board, Valid, Color, Level, Move):-
    Level = 2,
    check_pair(Board, Valid, Color, [], New),
    check_possible(Board, New, Color, [], Coords),
    length(Coords, Length),
    Length > 0,
    random(0, Length, Index),
    nth0(Index, Coords, Move).
randomMove(Board, Valid, ?, Level, Move):-
    Level = 2,
    rand_move(Board, Valid, [], All_Moves),
    length(All_Moves, Length),
    random(0, Length, Index),
    nth0(Index, All_Moves, Move).

/*
* move(+Player, +Board, -NewBoard, +WhiteSpots, -NewWhiteSpots, +BlackSpots, -NewBlackSpots, +LevelWhite, +LevelBlack)
* @brief Predicate that makes a move depending on the player and the phase of the game
* @param Player The player
* @param Board The board
* @param NewBoard The new board after the move
* @param WhiteSpots The list of the valid moves of the white stones
* @param NewWhiteSpots The new list of the valid moves of the white stones after the move
* @param BlackSpots The list of the valid moves of the black stones
* @param NewBlackSpots The new list of the valid moves of the black stones after the move
* @param LevelWhite The level of the white player (0 = human, 1 = easy, 2 = smart)
* @param LevelBlack The level of the black player (0 = human, 1 = easy, 2 = smart)
*/

move(Player, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 1,
    Player = 1,
    LevelWhite = 0,
    whiteStones(NrWhiteStones),
    NrWhiteStones > 0,
    !,
    write('--- Player 1 ---'),
    nl,
    write('Choose a column (0-5): '),
    read(Column),
    write('Choose a row (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    replace(RowList, Column, white, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    checkPlayer1Move(RowList, NewRowList, Board, Column, L, white, NewBoard, WhiteSpots, BlackSpots, LevelWhite, LevelBlack),
    NewNumber is NrWhiteStones - 1,
    retract(whiteStones(NrWhiteStones)),
    assert(whiteStones(NewNumber)),
    boardWhite(WhiteOnBoard),
    NewWhiteOnBoard is WhiteOnBoard + 1,
    retract(boardWhite(WhiteOnBoard)),
    assert(boardWhite(NewWhiteOnBoard)),
    nl,
    write('Number of white stones left: '),
    nl,
    changeSpots(WhiteSpots, Column, L, NewWhiteSpots),
    nth0(L, BlackSpots, BlackList),
    replace(BlackList, Column, 1, NewBlackList),
    replace(BlackSpots, L, NewBlackList, NewBlackSpots),
    displayGame(NewBoard),
    nl,
    write('Number of white stones left: '),
    write(NewNumber),
    nl,
    write('Number of white stones on board: '),
    write(NewWhiteOnBoard),
    nl.
move(Player, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots,LevelWhite, _):-
    phase(Phase),
    Phase = 1,
    Player = 1,
    LevelWhite \= 0,
    whiteStones(NrWhiteStones),
    NrWhiteStones > 0,
    !,
    write('--- Player 1 ---'),
    sleep(1),
    valid_moves(WhiteSpots,_, white, Valid),
    choose_move(Board,Valid,white, LevelWhite, Move),
    nth0(0, Move, L),
    nth0(1, Move, Column),
    pos(L, Row),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nth0(L, Board, RowList),
    replace(RowList, Column, white, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    NewNumber is NrWhiteStones - 1,
    retract(whiteStones(NrWhiteStones)),
    assert(whiteStones(NewNumber)),
    boardWhite(WhiteOnBoard),
    NewWhiteOnBoard is WhiteOnBoard + 1,
    retract(boardWhite(WhiteOnBoard)),
    assert(boardWhite(NewWhiteOnBoard)),
    changeSpots(WhiteSpots, Column, L, NewWhiteSpots),
    nth0(L, BlackSpots, BlackList),
    replace(BlackList, Column, 1, NewBlackList),
    replace(BlackSpots, L, NewBlackList, NewBlackSpots),
    displayGame(NewBoard),
    nl,
    write('Number of white stones left: '),
    write(NewNumber),
    nl,
    write('Number of white stones on board: '),
    write(NewWhiteOnBoard),
    nl.
move(Player, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 1,
    Player = 2,
    LevelBlack = 0,
    blackStones(NrBlackStones),
    NrBlackStones > 0,
    !,
    write('--- Player 2 ---'),
    nl,
    write('Choose a column (0-5): '),
    read(Column),
    write('Choose a row (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    replace(RowList, Column, black, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    checkPlayer2Move(RowList, NewRowList, Board, Column, L, black, NewBoard, WhiteSpots, BlackSpots,LevelWhite, LevelBlack),
    NewNumber is NrBlackStones - 1,
    retract(blackStones(NrBlackStones)),
    assert(blackStones(NewNumber)),
    boardBlack(BlackOnBoard),
    NewBlackOnBoard is BlackOnBoard + 1,
    retract(boardBlack(BlackOnBoard)),
    assert(boardBlack(NewBlackOnBoard)),
    changeSpots(BlackSpots, Column, L, NewBlackSpots),
    nth0(L, WhiteSpots, WhiteList),
    replace(WhiteList, Column, 1, NewWhiteList),
    replace(WhiteSpots, L, NewWhiteList, NewWhiteSpots),
    displayGame(NewBoard),
    nl,
    write('Number of black stones left: '),
    write(NewNumber),
    nl,
    write('Number of black stones on board: '),
    write(NewBlackOnBoard),
    nl.
move(Player, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots, _, LevelBlack):-
    phase(Phase),
    Phase = 1,
    Player = 2,
    LevelBlack \= 0,
    !,
    blackStones(NrBlackStones),
    NrBlackStones > 0,
    !,
    write('--- Player 2 ---'),
    sleep(1),
    valid_moves(BlackSpots, _,black, Valid),
    choose_move(Board,Valid, black, LevelBlack, Move),
    nth0(0, Move, L),
    nth0(1, Move, Column),
    pos(L, Row),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nth0(L, Board, RowList),
    replace(RowList, Column, black, NewRowList),
    replace(Board, L, NewRowList, NewBoard),
    NewNumber is NrBlackStones - 1,
    retract(blackStones(NrBlackStones)),
    assert(blackStones(NewNumber)),
    boardBlack(BlackOnBoard),
    NewBlackOnBoard is BlackOnBoard + 1,
    retract(boardBlack(BlackOnBoard)),
    assert(boardBlack(NewBlackOnBoard)),
    changeSpots(BlackSpots, Column, L, NewBlackSpots),
    nth0(L, WhiteSpots, WhiteList),
    replace(WhiteList, Column, 1, NewWhiteList),
    replace(WhiteSpots, L, NewWhiteList, NewWhiteSpots),
    displayGame(NewBoard),
    nl,
    write('Number of black stones left: '),
    write(NewNumber),
    nl,
    write('Number of black stones on board: '),
    write(NewBlackOnBoard),
    nl.

move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 2,
    Player = 1,
    LevelWhite = 0,
    !,
    write('--- Player 1 ---'),
    nl,
    write('Choose the column of the stone to move (0-5): '),
    read(Column),
    write('Choose the row of the stone to move (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    nth0(Column, RowList, Stone),
    checkStone(Stone, white),  % check if position chosen has a white stone
    write('Choose the column to move the stone to (0-5): '),
    read(NewColumn),
    write('Choose the row to move the stone to (a-e): '),
    read(NewRow),
    pos(NewL, NewRow),
    nth0(NewL, Board, NewRowList),
    nth0(NewColumn, NewRowList, NewStone),
    checkStone(NewStone, empty), % check if position to move stone to is empty
    checkAdjacentMove(Column, L, NewColumn, NewL),
    !,
    replace2(RowList, Column, empty, NewRowList1),
    replace(Board, L, NewRowList1, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace2(NewRowListt, NewColumn, Stone, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, white, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):- % if move is not valid, ask again
    phase(Phase),
    Phase = 2,
    Player = 1,
    LevelWhite = 1,
    !,
    write('--- Player 1 ---'),
    sleep(1),
    nl,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, white)), All_Stones),
    randomMove(Board, All_Stones, white, LevelWhite, Coord),
    phase2_valid_moves(Board, Coord, Valid_List),
    randomMove(Board, Valid_List, white, LevelWhite, Move),
    nth0(0, Coord, Column),
    nth0(1, Coord, L),
    nth0(0, Move, NewColumn),
    nth0(1, Move, NewL),
    pos(L, Row),
    pos(NewL, NewRow),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nl,
    write('New column: '),
    write(NewColumn),
    nl,
    write('New row: '),
    write(NewRow),
    nth0(L, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace(NewRowListt, NewColumn, white, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, white, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 2,
    Player = 1,
    LevelWhite = 2,
    !,
    write('--- Player 2 ---'),
    sleep(1),
    nl,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, white)), All_Stones),
    randomMove(Board, All_Stones, white, LevelWhite, Move),
    nth0(0, Move, Start),
    nth0(1, Move, Finish),
    nth0(0, Start, L),
    nth0(1, Start, Column),
    nth0(0, Finish, NewL),
    nth0(1, Finish, NewColumn),
    pos(L, Row),
    pos(NewL, NewRow),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nl,
    write('New column: '),
    write(NewColumn),
    nl,
    write('New row: '),
    write(NewRow),
    nth0(L, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace(NewRowListt, NewColumn, white, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, white, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 2,
    Player = 2,
    LevelBlack = 0,
    !,
    write('--- Player 2 ---'),
    nl,
    write('Choose the column of the stone to move (0-5): '),
    read(Column),
    write('Choose the row of the stone to move (a-e): '),
    read(Row),
    pos(L, Row),
    nth0(L, Board, RowList),
    nth0(Column, RowList, Stone),
    checkStone(Stone, black),  % check if position chosen has a black stone
    write('Choose the column to move the stone to (0-5): '),
    read(NewColumn),
    write('Choose the row to move the stone to (a-e): '),
    read(NewRow),
    pos(NewL, NewRow),
    nth0(NewL, Board, NewRowList),
    nth0(NewColumn, NewRowList, NewStone),
    checkStone(NewStone, empty), % check if position to move stone to is empty
    checkAdjacentMove(Column, L, NewColumn, NewL),
    !,
    replace2(RowList, Column, empty, NewRowList1),
    replace(Board, L, NewRowList1, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace2(NewRowListt, NewColumn, Stone, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, black, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):- % if move is not valid, ask again
    phase(Phase),
    Phase = 2,
    Player = 2,
    LevelBlack = 1,
    !,
    write('--- Player 2 ---'),
    sleep(1),
    nl,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, black)), All_Stones),
    randomMove(Board, All_Stones, black, LevelBlack, Coord),
    phase2_valid_moves(Board, Coord, Valid_List),
    randomMove(Board, Valid_List, black, LevelBlack, Move),
    nth0(0, Coord, L),
    nth0(1, Coord, Column),
    nth0(0, Move, NewL),
    nth0(1, Move, NewColumn),
    pos(L, Row),
    pos(NewL, NewRow),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nl,
    write('New column: '),
    write(NewColumn),
    nl,
    write('New row: '),
    write(NewRow),
    nth0(L, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace(NewRowListt, NewColumn, black, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, black, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
move(Player, Board, _, WhiteSpots, _, BlackSpots, _,LevelWhite, LevelBlack):-
    phase(Phase),
    Phase = 2,
    Player = 2,
    LevelBlack = 2,
    !,
    write('--- Player 2 ---'),
    sleep(1),
    nl,
    findall([X, Y], (nth0(X, Board, Row), nth0(Y, Row, black)), All_Stones),
    randomMove(Board, All_Stones, black, LevelBlack, Move),
    nth0(0, Move, Start),
    nth0(1, Move, Finish),
    nth0(0, Start, L),
    nth0(1, Start, Column),
    nth0(0, Finish, NewL),
    nth0(1, Finish, NewColumn),
    pos(L, Row),
    pos(NewL, NewRow),
    write('Move chosen by computer: '),
    nl,
    write('Column: '),
    write(Column),
    nl,
    write('Row: '),
    write(Row),
    nl,
    write('New column: '),
    write(NewColumn),
    nl,
    write('New row: '),
    write(NewRow),
    nth0(L, Board, RowList),
    replace2(RowList, Column, empty, NewRowList),
    replace(Board, L, NewRowList, NewBoard1),
    nth0(NewL, NewBoard1, NewRowListt),
    replace(NewRowListt, NewColumn, black, NewRowList2),
    replace(NewBoard1, NewL, NewRowList2, NewBoard2),
    checkRemove(NewBoard2, NewRowList2, NewL, NewColumn, black, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).