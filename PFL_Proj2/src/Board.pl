:- dynamic phaseTwoBoard/1.

/**
*@file Board.pl
*@brief Board predicates and predicates to display the board
*

/**
*Emtpy Board for the beginning of the game
*/
emptyBoard([[empty,empty,empty,empty,empty,empty],
            [empty,empty,empty,empty,empty,empty],
            [empty,empty,empty,empty,empty,empty],
            [empty,empty,empty,empty,empty,empty],
            [empty,empty,empty,empty,empty,empty]]).

phaseTwoBoard([[empty,empty,empty,empty,empty,empty],
               [empty,empty,empty,empty,empty,empty],
               [empty,empty,empty,empty,empty,empty],
               [empty,empty,empty,empty,empty,empty],
               [empty,empty,empty,empty,empty,empty]]).

/**
*A test board for phase two
*/
phaseTwoBoardTest([[white,black,white,black,white,black],
                   [empty,empty,empty,empty,empty,empty],
                   [black,white,black,white,black,white],
                   [empty,empty,empty,empty,empty,empty],
                   [white,black,white,black,white,black]]).


/**
*Board to compare when there are no valid moves
*
*/
noValidMoves(([[1,1,1,1,1,1],
               [1,1,1,1,1,1],
               [1,1,1,1,1,1],
               [1,1,1,1,1,1],
               [1,1,1,1,1,1]])).
/**
*Icons and their respective internal representation
*
*/
icon(empty,'.').
icon(black,'B'). 
icon(white,'W').


/**
*Positions of the board and their numbers in the matrix
*
*/
pos(0,'a'). 
pos(1,'b').
pos(2,'c'). 
pos(3,'d').
pos(4,'e'). 

/**
*displayGame(+Board)
* Main predicate to display the board
* Receives the game state, a matrix representing the board, and displays it
*/
displayGame(Board):-
    nl,
    write('   | 0 | 1 | 2 | 3 | 4 | 5 |\n'),
    write('---|---|---|---|---|---|---|\n'),
    displayBoardAux(Board, 0).

/**
*displayBoardAux(+Board, +Number)
* Auxiliary predicate to display the board
* Receives the game state, a matrix representing the board, and displays it
*/
displayBoardAux([], 5).

displayBoardAux([Head|Tail], Number) :-
    pos(Number, L),
    write(' '),
    write(L),
    Number1 is Number + 1,
    write(' |'),
    printRow(Head),
    write('\n---|---|---|---|---|---|---\n'),
    displayBoardAux(Tail, Number1).

/**
*printRow(+Row)
* Auxiliary predicate to display the board
* Receives a row of the board and displays it
*/
printRow([]).

printRow([Head|Tail]) :-
    icon(Head,S),
    format(' ~s |', [S]),
    printRow(Tail).
/**
*initBoard(+Board)
* Predicate to initialize the board
* Receives the game state, a matrix representing the board, and displays it
* It is called at the beginning of the game
*/
initBoard(Board1):-
    emptyBoard(Board1),
    displayGame(Board1).
