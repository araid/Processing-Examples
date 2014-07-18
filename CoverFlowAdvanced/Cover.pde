/**
 Quick Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 USING: 3D (openGL), events (controlp5) and animation (ani)
 */

class Cover 
{
  boolean loading;
  float rotationY;
  String fileName;
  PVector position;
  PImage img;

  Cover( String name ) {
    this.position = new PVector(0.0, 0.0, 0.0);
    this.rotationY = 0.0;
	this.fileName = name;
	this.loading = false;
  }

  public void drawCover() 
  {
    if(this.img != null) {
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
  
  public void loadCoverImage()
  {
	  if(!this.loading) {
		  this.loading = true;
		  this.img = requestImage(this.fileName); //asynchronous loading
		  println("requesting cover " + this.fileName);
	  }
  }
  
  public void unloadCoverImage()
  {
	  if(this.loading) {
		  this.loading = false;
	  	  this.img = null;
  		  println("unloading cover " + this.fileName);
	  }
  }
}

