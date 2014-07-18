/**
 Quick Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 USING: 3D (openGL), events (controlp5) and animation (ani)
 */

class Cover 
{
  int transparency;
  float rotationY;
  PVector position;
  PImage img;

  Cover( String name ) {
    this.position = new PVector(0.0, 0.0, 0.0);
    this.rotationY = 0.0;
    this.transparency = 255;
    this.img = loadImage(name);
  }

  public void drawCover() 
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateY(rotationY);

    // Main image
    imageMode(CENTER);
    noTint();
    image(img, 0, 0, 200, 200); 

    // Reflection
	pushMatrix();
	scale(1, -1);
	tint(50);
    image(img, 0, -200, 200, 200);
	popMatrix();

    noTint();
    popMatrix();
  }
}

