# 6.00 Problem Set 3
# 
# Hangman game
#

# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)

import random
import string

WORDLIST_FILENAME = "/home/portia/Dropbox/Dev/School/Python6.00.1/ps3/words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print "Loading word list from file..."
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r', 0)
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = string.split(line)
    print "  ", len(wordlist), "words loaded."
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = loadWords()

def isWordGuessed(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: boolean, True if all the letters of secretWord are in lettersGuessed;
      False otherwise
    '''
    # FILL IN YOUR CODE HERE...
    temp = list(secretWord)
    count = 0
    for e in range(len(temp)):
        if temp[e] in lettersGuessed:
            count += 1
            if count == len(secretWord):
                return True
    return False

def getGuessedWord(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters and underscores that represents
      what letters in secretWord have been guessed so far.
    '''
    # FILL IN YOUR CODE HERE...
    temp = list(secretWord)
    word = []
    for e in range(len(temp)):
        if temp[e] in lettersGuessed:
            word.append(temp[e])
        else:
            word.append('_')
    return "".join(word)

def getAvailableLetters(lettersGuessed):
    '''
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters that represents what letters have not
      yet been guessed.
    '''
    # FILL IN YOUR CODE HERE...
    alpha = 'abcdefghijklmnopqrstuvwxyz'
    for e in range(len(lettersGuessed)):
        if lettersGuessed[e] in alpha:
            alpha = alpha.replace(lettersGuessed[e],"")
    return alpha

def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE...
    lettersGuessed = []
    g = ""
    guessesLeft = 10
    while True:
            print "Secret Word: " + getGuessedWord(secretWord, lettersGuessed) + '\n'
            print "Available Letters: " + getAvailableLetters(lettersGuessed) + '\n'
            print "You have " + str(guessesLeft) + " guesses left" + '\n'
            
            while True:
                g = raw_input ("What is your next guess:")
                
                if g not in lettersGuessed:
                    break
                else:
                    print "You already guessed that. Try again."
            
            lettersGuessed.append(g)
            if isWordGuessed(secretWord, lettersGuessed) == True:
                print "You Win"
                break
            else:
                if g not in secretWord:
                    guessesLeft -= 1
                if guessesLeft == 0:
                    print "You Lose"
                    break

# When you've completed your hangman function, uncomment these two lines
# and run this file to test! (hint: you might want to pick your own
# secretWord while you're testing)

# secretWord = chooseWord(wordlist).lower()
# hangman(secretWord)
