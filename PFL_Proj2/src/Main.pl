:- consult('Game.pl').
:- consult('Menu.pl').

/* main.pl:-
 * @brief Main file
 * @details This file is the main file of the program. It is responsible for calling the predicate that starts the game.
 */


/**
    * play:-
    * @brief Main predicate
    * @details This predicate is the main predicate of the program. It is responsible for starting the game.
    * It is the only predicate that needs to be called to start the game.
    * @param None
    */
play:-
    menu.