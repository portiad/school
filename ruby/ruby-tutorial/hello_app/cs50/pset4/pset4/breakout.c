//
// breakout.c
//
// Computer Science 50
// Problem Set 4
//

// standard libraries
#define _XOPEN_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// Stanford Portable Library
#include "gevents.h"
#include "gobjects.h"
#include "gwindow.h"

// height and width of game's window in pixels
#define HEIGHT 600
#define WIDTH 400

// number of rows of bricks
#define ROWS 5

// number of columns of bricks
#define COLS 10

// radius of ball in pixels
#define RADIUS 10

// lives
#define LIVES 3

// prototypes
void initBricks(GWindow window);
GOval initBall(GWindow window);
GRect initPaddle(GWindow window);
GLabel initScoreboard(GWindow window);
void updateScoreboard(GWindow window, GLabel label, int points);
GObject detectCollision(GWindow window, GOval ball);

int main(void)
{
    // seed pseudorandom number generator
    srand48(time(NULL));

    // instantiate window
    GWindow window = newGWindow(WIDTH, HEIGHT);

    // instantiate bricks
    initBricks(window);

    // instantiate ball, centered in middle of window
    GOval ball = initBall(window);

    // instantiate paddle, centered at bottom of window
    GRect paddle = initPaddle(window);

    // instantiate scoreboard, centered in middle of window, just above ball
    GLabel label = initScoreboard(window);

    // number of bricks initially
    int bricks = COLS * ROWS;

    // number of lives initially
    int lives = LIVES;

    // number of points initially
    int points = 0;
    
    double xvelocity = drand48() * .05;
    double yvelocity = .05;
    
    waitForClick();

    // keep playing until game over
    while (lives > 0 && bricks > 0)
    {
        updateScoreboard(window, label, points);
        
        move(ball, xvelocity, yvelocity);
        
        //Moves paddle with the mouse
        GEvent event = getNextEvent(MOUSE_EVENT);
        
        if (event != NULL){
            if (getEventType(event) == MOUSE_MOVED) {
                double x = getX(event) - getWidth(paddle) / 2;
                if (x < 0) {
                    x = 0;
                }
                if (x > 330) {
                    x = 330;
                }
                setLocation(paddle, x, 560);
            }
        }
        //Detects collision
        GObject collision = detectCollision(window, ball);
        
        if (collision != NULL && strcmp(getType(collision), "GRect")== 0) {
        
            yvelocity *= -1;
            
            //Detects collision on a brick
            if (collision != paddle)
            {
                removeGWindow(window, collision);
                bricks--;
                points++;
                updateScoreboard(window, label, points);   
            }
        }
        
        //Moves ball back if it is at the new of the window
        if (getX(ball) + getWidth(ball) >= getWidth(window) || getX(ball) <= 0) {
            xvelocity *= -1;
        }   
        
        if (getY(ball) <= 0) {
            yvelocity *= -1;
        }
        
        //If the ball goes to the bottom of the screen it subtracts points and restarts the game
        if (getY(ball) + getHeight(ball) >= getHeight(window)) {
            lives--; 
            setLocation(ball,190,290);
            setLocation(paddle,165,560); 
            waitForClick();    
        }             
    }
    
    // wait for click before exiting
    waitForClick();

    // game over
    closeGWindow(window);
    return 0;
}

/**
 * Initializes window with a grid of bricks.
 */
void initBricks(GWindow window)
{
    int ylocation = 10;
    int xlocation = 2;
    string color = "RED";
    
    //Changes color of the bricks alternating by rows
    for (int i = 0, colorchange = 0; i < ROWS; i++, colorchange++){

        for (int j = 0; j < COLS; j++){
            GRect block = newGRect(xlocation,ylocation,35,10);
            setFilled(block,true);
            setColor(block,color);
            add(window, block);
            xlocation += 40;
        }
        ylocation +=15;
        xlocation = 2;
        
        if (colorchange == 0) {
            color = "ORANGE";
        }
        else if (colorchange == 1) {
            color = "YELLOW";
        }
        else if (colorchange == 2) {
            color = "GREEN";
        }   
        else if (colorchange == 3) {
            color = "CYAN";
        }
        else {
            color = "RED";
            colorchange = -1;
        }
    }        
}

/**
 * Instantiates ball in center of window.  Returns ball.
 */
GOval initBall(GWindow window)
{
    GOval ball = newGOval(190,290,20,20);
    setFilled(ball,true);
    setColor(ball,"BLACK");
    add(window, ball);
    
    return ball;
}

/**
 * Instantiates paddle in bottom-middle of window.
 */
GRect initPaddle(GWindow window)
{
    GRect paddle = newGRect(165,560,70,10);
    setFilled(paddle,true);
    setColor(paddle,"BLACK");
    add(window,paddle);
    
    return paddle;
}

/**
 * Instantiates, configures, and returns label for scoreboard.
 */
GLabel initScoreboard(GWindow window)
{
    GLabel label = newGLabel(" ");
    setLocation(label,185,310);
    setFont(label,"SansSerif-50");
    setColor(label,"GRAY");
    add(window,label);
 
    return label;
}

/**
 * Updates scoreboard's label, keeping it centered in window.
 */
void updateScoreboard(GWindow window, GLabel label, int points)
{
    // update label
    char s[12];
    sprintf(s, "%i", points);
    setLabel(label, s);

    // center label in window
    double x = (getWidth(window) - getWidth(label)) / 2;
    double y = (getHeight(window) - getHeight(label)) / 2;
    setLocation(label, x, y);
}

/**
 * Detects whether ball has collided with some object in window
 * by checking the four corners of its bounding box (which are
 * outside the ball's GOval, and so the ball can't collide with
 * itself).  Returns object if so, else NULL.
 */
GObject detectCollision(GWindow window, GOval ball)
{
    // ball's location
    double x = getX(ball);
    double y = getY(ball);

    // for checking for collisions
    GObject object;

    // check for collision at ball's top-left corner
    object = getGObjectAt(window, x, y);
    if (object != NULL)
    {
        return object;
    }

    // check for collision at ball's top-right corner
    object = getGObjectAt(window, x + 2 * RADIUS, y);
    if (object != NULL)
    {
        return object;
    }

    // check for collision at ball's bottom-left corner
    object = getGObjectAt(window, x, y + 2 * RADIUS);
    if (object != NULL)
    {
        return object;
    }

    // check for collision at ball's bottom-right corner
    object = getGObjectAt(window, x + 2 * RADIUS, y + 2 * RADIUS);
    if (object != NULL)
    {
        return object;
    }

    // no collision
    return NULL;
}
