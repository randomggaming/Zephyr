/**
**  Class name:      Character
**  Description:     Used to represent the users character they will be controlling
**                   while they play the game.
**/
public class CCharacter extends Sprite
{
  public float velocityX;
  private float maxSpeedX;
  
  /**
  **  Function:  CCharacter
  **  Params:    PApplet applet, String imageFileName,
  **             int cols (number of columns in sprite sheet),
  **             int rows (number of rows in sprite sheet),
  **             int zOrder (how far away the object is from the orgin on the z-axis),
  **             boolean register (should we keep track of this object's zOrder)
  **  Returns:   an instance of CCharacter
  **
  **  Summary:   Constructor for CCharacter.
  **/
  public CCharacter(PApplet applet, String imageFileName, int cols, int rows,
                    int zOrder, boolean register)
  {
    super(applet, imageFileName, cols, rows, zOrder, register);
    
    velocityX = 0.0;
    maxSpeedX = 30.0;
  }
  
  /**
  **  Function:  draw
  **  Params:    none
  **  Returns:   nothing
  **
  **  Summary:   Draws the character.
  **/
  public void draw()
  {
    super.draw();
  }
  
  /**
  **  Function:  update
  **  Params:    float elapsedTime
  **  Returns:   nothing
  **
  **  Summary:   Updates all the values for this character.
  **/
  public void update(float elapsedTime)
  {
    super.update(elapsedTime);
    
    // Cap the velocityX.
    if (abs(velocityX) > maxSpeedX)
    {
      if (velocityX < 0)
      {
        velocityX = maxSpeedX * -1;
      }
      else
      {
        velocityX = maxSpeedX;
      }
      
      setVelXY(velocityX, 0);
    }
    else
    {
      setVelXY(velocityX, 0);
    }
  }
  
}
