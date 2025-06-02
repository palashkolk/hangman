# hangman
The ODIN project ruby exercise

Requirement:
1. Command line game
2. One player plays against comuter (Computer is the word selector)
3. Download google-10000-english-no-swears.txt from https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt
4. When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.
5. You don’t need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses they have before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.
6. Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.
7. Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects.
8. When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!



Pseudocode
1. Create Computer as host player
    a) Instance creates computer host with a name and secret word
    b) Outputs messages that 'computer has chosen a word and now guess it'
    c) Word is checked against letter count. It should be between 5 and 12 before returning it

2. Create Human as guesser player
    a) Instance creates a player with name
    b) calling guess methods takes input from keyboard and returns it
    c) Vrifies if the put is valid letter
3. Game play starts
    a) Game instance creates setup with current count and max count
    b) Shows message that the game has started
    c) shows count left for guessing before the game ends
    d) After every guess:
    d) Shows correct letters in the word with dashes for the yet to guessed letters
    e) Shows wronly guessed letter in spearate row with label
    f) Shows the stick figure status 
    g) ends game when hangman completed or count is finished
    h) Gives option to play another round