:- consult('Board.pl').       
:- consult('Logic.pl').

/**
    * @file main.pl
    * @brief Main file for the game
    * @details This file contains the main predicates for the game
*/

/**
    * playPlayer1(+Board, +WhiteSpots, +BlackSpots, +LevelWhite, +LevelBlack)
    * @brief Predicate that plays the first phase of the game for player 1
    * @details This predicate plays the first phase of the game for player 1, where the players place their stones on the board
    * @param Board The current board/game state
    * @param the list of valid coords for white stones left to place on the board
    * @param the list of valid coords for black stones left to place on the board
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)

*/
playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    checkInside(empty, WhiteSpots),
    whiteStones(NrWhiteStones),
    NrWhiteStones > 0,
    !,
    move(1, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots, LevelWhite, LevelBlack),
    playPlayer2(NewBoard, NewWhiteSpots, NewBlackSpots, LevelWhite, LevelBlack).
playPlayer1(Board, _, _, LevelWhite, LevelBlack):-
    whiteStones(NrWhiteStones),
    NrWhiteStones = 0,
    blackStones(NrBlackStones),
    NrBlackStones = 0,
    !,
    write('No more stones left!'),
    nl,
    write('Phase 1 is over!'),
    nl,
    phaseTwoBoard(B),
    retract(phaseTwoBoard(B)),
    assert(phaseTwoBoard(Board)),
    write('Second phase starting'), nl,
    playSecondPhase(LevelWhite, LevelBlack).
playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    whiteStones(NrWhiteStones),
    NrWhiteStones = 0,
    noValidMoves(List),
    List \= BlackSpots,
    !,
    write('No more white stones left!'),
    nl,
    write('Player 2\'s turn!'),
    nl,
    blackStones(NrBlackStones),
    NrBlackStones > 0,
    playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
playPlayer1(Board, _, BlackSpots, LevelWhite, LevelBlack):-
    whiteStones(NrWhiteStones),
    NrWhiteStones = 0,
    noValidMoves(List),
    List = BlackSpots,
    !,
    write('No more white stones left! And black is out of valid moves!'),
    nl,
    write('Phase 1 is over!'),
    nl,
    phaseTwoBoard(B),
    retract(phaseTwoBoard(B)),
    assert(phaseTwoBoard(Board)),
    write('Second phase starting'), nl,
    playSecondPhase(LevelWhite, LevelBlack).
playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    noValidMoves(List),
    List = WhiteSpots,
    List = BlackSpots,
    !,
    write('No more valid moves left for both players!'),
    nl,
    write('Phase 1 is over!'),
    nl,
    phaseTwoBoard(B),
    retract(phaseTwoBoard(B)),
    assert(phaseTwoBoard(Board)),
    write('Second phase starting'), nl,
    playSecondPhase(LevelWhite, LevelBlack).
playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    write('You have no valid moves left!'),
    nl,
    blackStones(NrBlackStones),
    NrBlackStones > 0,
    write('Player 2\'s turn!'),
    nl,
    playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
playPlayer1(Board, _, _, LevelWhite, LevelBlack):-
    write('You have no valid moves left!'),
    nl,
    blackStones(NrBlackStones),
    NrBlackStones = 0,
    !,
    write('No more black stones left!'),
    nl,
    write('Phase 1 is over!'),
    nl,
    phaseTwoBoard(B),
    retract(phaseTwoBoard(B)),
    assert(phaseTwoBoard(Board)),
    write('Second phase starting'), nl,
    playSecondPhase(LevelWhite, LevelBlack).
/*
    * playPlayer2(+Board, +WhiteSpots, +BlackSpots, +LevelWhite, +LevelBlack)
    * @brief Predicate that plays the first phase of the game for player 2
    * @details This predicate plays the first phase of the game for player 2, where the players place their stones on the board
    * @param Board The current board/game state
    * @param the list of valid coords for white stones left to place on the board
    * @param the list of valid coords for black stones left to place on the board
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)
*/

playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    checkInside(empty, BlackSpots),
    blackStones(NrBlackStones),
    NrBlackStones > 0,
    !,
    move(2, Board, NewBoard, WhiteSpots, NewWhiteSpots, BlackSpots, NewBlackSpots, LevelWhite, LevelBlack),
    playPlayer1(NewBoard, NewWhiteSpots, NewBlackSpots, LevelWhite, LevelBlack).
playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    blackStones(NrBlackStones),
    NrBlackStones = 0,
    write('No more black stones left!'),
    nl,
    write('Player 1\'s turn!'),
    nl,
    whiteStones(NrWhiteStones),
    NrWhiteStones > 0,
    playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).
playPlayer2(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack):-
    write('You have no valid moves left!'),
    nl,
    write('Player 1\'s turn!'),
    nl,
    playPlayer1(Board, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).

/*
    * playFirstPhase(+LevelWhite, +LevelBlack)
    * @brief Predicate that plays the first phase of the game
    * @details This predicate plays the first phase of the game, where the players place their stones on the board,
    *          it is called at the start of the game, by the menus after the players have chosen the game mode and/or level
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)
*/

playFirstPhase(LevelWhite, LevelBlack):-
    initBoard(Board1),
    emptyBoard(WhiteSpots),
    emptyBoard(BlackSpots),
    whiteStones(NrWhiteStones),
    retract(whiteStones(NrWhiteStones)),
    assert(whiteStones(12)),
    blackStones(NrBlackStones),
    retract(blackStones(NrBlackStones)),
    assert(blackStones(12)),
    boardWhite(WhiteOnBoard),
    retract(boardWhite(WhiteOnBoard)),
    assert(boardWhite(0)),
    boardBlack(BlackOnBoard),
    retract(boardBlack(BlackOnBoard)),
    assert(boardBlack(0)),
    phase(Phase),
    retract(phase(Phase)),
    assert(phase(1)),
    playPlayer1(Board1, WhiteSpots, BlackSpots, LevelWhite, LevelBlack).




% Phase 2 


/*
    * playSecondPhase1 (+Board, +White, +Black, +LevelWhite, +LevelBlack)
    * @brief Predicate that plays the second phase of the game for player 1
    * @details This predicate plays the second phase of the game for player 1, where the players move their stones on the board to adjacent positions
               to try and capture the opponent's stones
    * @param Board The current board/game state
    * @param White The number of white stones on the board
    * @param Black The number of black stones on the board
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)
*/
playSecondPhase1(Board, White, Black, LevelWhite, LevelBlack):-
    White \= 0,
    displayGame(Board),
    nl,
    write('White stones left: '),
    write(White),
    nl,
    move(1, Board, _, White, _, Black, _, LevelWhite, LevelBlack).
playSecondPhase1(_,White,_, _, _):-
    White = 0,
    !,
    write('No more white stones left!'),
    nl,
    write('Player 2 won!'),
    nl,
    menu.
playSecondPhase1(Board, White, Black, LevelWhite, LevelBlack):-
    nl,
    write('Invalid move!'),
    nl,
    playSecondPhase1(Board, White, Black, LevelWhite, LevelBlack).
    
/*
    * playSecondPhase2 (+Board, +White, +Black, +LevelWhite, +LevelBlack)
    * @brief Predicate that plays the second phase of the game for player 2
    * @details This predicate plays the second phase of the game for player 2, where the players move their stones on the board to adjacent positions
               to try and capture the opponent's stones
    * @param Board The current board/game state
    * @param White The number of white stones on the board
    * @param Black The number of black stones on the board
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)
*/

playSecondPhase2(Board, White, Black, LevelWhite, LevelBlack):-
    Black \= 0,
    displayGame(Board),
    nl,
    write('Black stones left: '),
    write(Black),
    nl,
    move(2, Board, _, White, _, Black, _, LevelWhite, LevelBlack).
playSecondPhase2(_,_,Black, _, _):-
    Black = 0,
    !,
    write('No more black stones left!'),
    nl,
    write('Player 1 won!'),
    nl,
    menu.
playSecondPhase2(Board, White, Black, LevelWhite, LevelBlack):-
    nl,
    write('Invalid move!'),
    nl,
    playSecondPhase2(Board, White, Black, LevelWhite, LevelBlack).

/*
    * playSecondPhase(+LevelWhite, +LevelBlack)
    * @brief Predicate that plays the second phase of the game
    * @details This predicate plays the second phase of the game, where the players move their stones on the board to adjacent positions
               to try and capture the opponent's stones, it is called after the first phase of the game is over
    * @param LevelWhite The level of the white player (0 - human, 1 - easy bot, 2 - hard bot)
    * @param LevelBlack The level of the black player (0 - human, 1 - easy bot, 2 - hard bot)
*/

playSecondPhase(LevelWhite, LevelBlack):-
    phase(Phase),
    retract(phase(Phase)),
    assert(phase(2)),
    phaseTwoBoard(Board),
    boardWhite(White),
    boardBlack(Black),
    playSecondPhase1(Board, White, Black, LevelWhite, LevelBlack).