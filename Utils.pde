/**
**  Function:  getPixelData
**  Params:    PImage image, int x, int y
**  Returns:   int[] containing 3 int values
**
**  Summary:   This fucntion finds the RGB values
**             of any given pixel defined by an x and y.
**/
int[] getPixelData(PImage image, int x, int y)
{
  // get the argb info.
  int argb = image.get(x, y) & 0x00ffffff;
  
  int rgb[] = new int[]
  {
    (argb >> 16) & 0xff,   // red value
    (argb >> 8) & 0xff,    // green value
    (argb) & 0xff,         // blue value
  };
  
  return rgb; 
}

/**
**     Constants for common colors.
**/

// Black
final static int _black = 0xff000000;
// Blue
final static int _blue = 0xff0000ff;

// Light Sky Blue
final static int _lightSkyBlue = 0xffb0e2ff;
