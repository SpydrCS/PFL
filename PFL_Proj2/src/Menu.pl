:- consult('game.pl').

/** menu.pl
 *  This file contains the predicates that are used to display the menu of the game.
*/

/** 
    * menu:-
    *  This predicate is used to display the menu of the game.
    *  It is called when the game is started.
    */
menu:-
write('Welcome to Wali!'),nl,
write('1. Play Human vs Human'),nl,
write('2. Play Human vs Computer'),nl,
write('3. Play Computer vs Human'),nl,
write('4. Play Computer vs Computer'),nl,
write('5. Close the game'),nl,
write('Enter your choice: '),
read(Choice),
actOnChoice(Choice).

/** 
    * actOnChoice(+Choice):-
    *@brief This predicate is used to call the appropriate predicate based on the choice of the user.
    *@param Choice The choice of the user.
    */

actOnChoice(1):-
    playFirstPhase(0,0).
actOnChoice(2):-
    write('Choose the difficulty of the computer: '),nl,
    write('1. Easy'),nl,
    write('2. Hard'),nl,
    write('Enter your choice: '),
    read(Level),
    playFirstPhase(0,Level).
actOnChoice(3):-
    write('Choose the difficulty of the computer: '),nl,
    write('1. Easy'),nl,
    write('2. Hard'),nl,
    write('Enter your choice: '),
    read(Level),
    playFirstPhase(Level,0).
actOnChoice(4):-
    write('Choose the difficulty of the first computer: '),nl,
    write('1. Easy'),nl,
    write('2. Hard'),nl,
    write('Enter your choice: '),
    read(Level1),
    write('Choose the difficulty of the second computer: '),nl,
    write('1. Easy'),nl,
    write('2. Hard'),nl,
    write('Enter your choice: '),
    read(Level2),
    playFirstPhase(Level1,Level2).
actOnChoice(5):-
    write('Thank you for playing!'), nl, halt.
