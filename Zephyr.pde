import java.util.HashSet;
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

/**
**   Global Vars.
**/
Game game;

// This is needed to stop multiple calls 
// being made while a key is held down.
HashSet<Integer> keysDown = new HashSet<Integer>();

void setup()
{
  // size of 700 x 550 is for debugging only.
  size(700, 550, P2D);
  game = new Game(this);
}

void draw()
{
  // We need to paint the sceen before we draw every frame.
  background(_lightSkyBlue);
  game.draw();
}

/**
**  grab all of the input from the keyboard and mouse.
**
**/
void keyPressed()
{
  keysDown.add(keyEvent.getKeyCode());
}

void keyReleased()
{
  keysDown.remove(keyEvent.getKeyCode());
}

void mousePressed()
{
  println("The " + mouseButton + " mouse button was pressed.");
}

void mouseReleased()
{
  println("The " + mouseButton + " mouse button was released.");
}

boolean keyDown(int kCode) { return keysDown.contains(kCode); }

/**
**  this game class is used to encaplulate what would otherwise
**  be global variables. 
**/
class Game
{
  PApplet applet;
  ArrayList<Sprite> dirtBlocks;    // holds all the dirt blocks.
  CCharacter player = null;        // The client user's character.
  StopWatch timer;                 // game timer.
  
  /**
  **  Function:  Game
  **  Params:    PApplet applet
  **  Returns:   instance of Game
  **
  **  Summary:   Constructor for Game class.
  **/
  public Game(PApplet applet)
  {
    this.applet = applet;
    
    // setup the game.
    setup();
  }
  
  /**
  **  Function:  setup
  **  Params:    none
  **  Returns:   nothing
  **
  **  Summary:   Set up the game. It's timers, sprites, and maps.
  **/
  private void setup()
  {
    // Create the game timer.
    timer = new StopWatch();
    
    // Create/load in the player's character.
    player = new CCharacter(applet, "testsprite.png", 3, 4, 100, true);
    player.setFrame(7);
            
    // Init the ArrayLists we will be using for our sprites.
    dirtBlocks = new ArrayList<Sprite>();
    
    // Load the map. This image is used to define
    //  the positions of all the objects and terrain.
    PImage map = loadImage("map1.png");
    
    // Sprite varible used to create sprites that will be stored
    // in an array.
    Sprite s;
    
    // Gather the argb info from the image.
    for (int y = 0; y < map.height; y += 20)
    {
      for (int x = 0; x < map.width; x += 20)
      {
        int[] rgb = getPixelData(map, x, y);
        color c = color(rgb[0], rgb[1], rgb[2]);
        
        // Check for what should be dirt.
        if (c == _black)
        {
          s = new Sprite(applet, "box_dirt.png", 50);
          s.setXY(x, y);
          dirtBlocks.add(s);
        }
        else if (c == _blue)    // blue marks player spawn points.
        {
          player.setXY(x, y);
        }
      }
    }
    
    // Start the game timer.
    startGame();
  }
  
  /**
  **  Function:  startGame
  **  Params:    none
  **  Returns:   nothing
  **
  **  Summary:   Starts the game timer by resetting it.
  **/
  private void startGame()
  {
    timer.reset();
  }
  
  /**
  **  Function:  draw
  **  Params:    none
  **  Returns:   nothing
  **
  **  Summary:   Handles drawing sprites and handels
  **             checking to see if we need to call the
  **             update function.
  **/
  public void draw()
  {
    // update the game before we draw anything.
    float elapsedTime = (float)timer.getElapsedTime();
    
    if (true)    // placehoder for pause feature.
    {
      update(elapsedTime);
    }
    
    // Draw the dirt blocks.
    for (Sprite sprite : dirtBlocks)
    {
      sprite.draw();
    }
    
    // draw the player's character.
    player.draw();
  }
  
  /**
  **  Function:  update
  **  Params:    float elapsedTime
  **  Returns:   nothing
  **
  **  Summary:   Checks for collisions, processes game input,
  **             and updates sprites.
  **/
  private void update(float elapsedTime)
  {
    // Check for Collisions
    processCollisions(elapsedTime);
    
    // Process game inputs.
    processUserGameInput(elapsedTime);
    
    // Update all sprites.
    updateAllSprites(elapsedTime);
  }
  
  /**
  **  Function:  processCollions
  **  Params:    float elapsedTime
  **  Returns:   nothing
  **
  **  Summary:   Checks for collisions dealing with
  **             all of the sprites in the game.
  **/
  private void processCollisions(float elapsedTime)
  {
    // Test for character hitting dirt blocks.
    for (Sprite sprite : dirtBlocks)
    {
      if (player.bb_collision(sprite))
      {
        // Get current values from player.
        float xPos = (float)player.getX();
        float yPos = (float)player.getY();
        float velX = (float)player.getVelX();
        float velY = (float)player.getVelY();
        
        // Update them to account for position.
        xPos -= 3 * velX * elapsedTime;
        yPos -= 3 * velY * elapsedTime;
        player.setXY(xPos, yPos);
        player.setVelXY(0, 0);
        
        break;
      }
    }
  }
  
  /**
  **  Function:  updateAllSprites
  **  Params:    float elapsedTime
  **  Returns:   nothing
  **
  **  Summary:   Calls update for every sprite.
  **/
  private void updateAllSprites(float elapsedTime)
  {
    player.update(elapsedTime);
  }
  
  /**
  **  Function:  processUserGameInput
  **  Params:    float elapsedTime
  **  Returns:   nothing
  **
  **  Summary:   Checks for keyboard and mouse input.
  **/
  private void processUserGameInput(float elapsedTime)
  {
    // Check for 'A' key
    if (keyDown('A'))
    {
      println("The 'A' key is down.");
      
      player.velocityX += 10;
      return;
    }
    
    // Check for 'D' key
    if (keyDown('D'))  
    {
      println("The 'D' key is down.");
      
      player.velocityX -= 10;
      return;
    }
    
    player.velocityX = 0.0;
  }
}
