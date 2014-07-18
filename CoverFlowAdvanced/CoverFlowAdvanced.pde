/**
 Advanced Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 USING: 3D (openGL), ui events (controlp5) and animation (ani)
 */

import controlP5.*;
import de.looksgood.ani.*;

// Ui
ControlP5 controlP5;
Button bNext, bPrev;
Slider slider;

// Graphics
PImage imgShadow;   
ArrayList<Cover> covers;
Ani coverAnimation;

int selectedCover = 0;
int MAX_LOADED_COVERS = 10;	// try a small number to see how this works. try a big one to hide loading/unloading from the user
float ANI_TIME = 0.5;

/* -------------- INIT -------------- */
void setup() 
{
  size(800, 400, OPENGL);
  smooth();
  noStroke();

  imgShadow = loadImage("shadow.png");

  // Create a cover for every image in the "data" folder
  File data = new File (sketchPath + "/data/covers/");
  String[] names = data.list();
  covers = new ArrayList<Cover>();
  
  for (int i=0; i<names.length; i++) {
    if(names[i].toLowerCase().endsWith(".jpg") || names[i].toLowerCase().endsWith(".png")) {
    	covers.add(new Cover("covers/" + names[i]));
	}
  }
  initCovers();
  loadCovers();
  
  // Init interface controlP5
  controlP5 = new ControlP5(this);
  bPrev 	= controlP5.addButton("Prev",-1, 20, 360, 80, 20); 
  bNext 	= controlP5.addButton("Next", 1, width-100, 360, 80, 20);
  slider 	= controlP5.addSlider("slider", 0, covers.size()-1, selectedCover, 120, 360, width - 240, 20); 
  slider.setLabelVisible(false);
  
  // Init animation
  Ani.init(this);
  
}

/* -------------- DRAW LOOP -------------- */
void draw() 
{
  background(200);
  hint(ENABLE_DEPTH_TEST);

  // move to the center to have easier coordinates
  pushMatrix();
  translate(width / 2, height / 2 ); 
  for( Cover cover : covers) {
    cover.drawCover();
  }
  popMatrix();  

  // disable depth test to draw control interface on top of everything
  hint(DISABLE_DEPTH_TEST);
  imageMode(CORNERS);
  image(imgShadow, 0.0, 0.0);
  
  // ui is automatically drawn 
  //controlP5.draw();
}


/* -------------- EVENT MANAGEMENT -------------- */
public void controlEvent(ControlEvent theEvent) 
{
  // Check where the event comes from, choose cover and snap
  if (theEvent.controller().name() == "slider") {           // slider
    selectedCover = round(theEvent.controller().value());
  }
  else {                                                    // buttons
    selectedCover += (int) theEvent.controller().value();
    slider.setValue(selectedCover);
  }

  // Lock buttons if we are in the first or last cover
  if (selectedCover == covers.size()) {
    selectedCover --;
    bNext.lock();
  }
  else if (selectedCover < 0) {
    selectedCover ++;
    bPrev.lock();
  }
  else {
    bNext.unlock();
    bPrev.unlock();
  }

  // Load and unload needed covers
  loadCovers();
  
  // Call Animation
  moveCovers();
}

/* ------------ COVER MANAGEMENT  ------------ */
public void loadCovers()
{
	int leftCover  = max(selectedCover - MAX_LOADED_COVERS / 2, 0);
	int rightCover = min(selectedCover + MAX_LOADED_COVERS / 2, covers.size()-1);

    for (int i=0; i<covers.size(); i++) {
		if (i>=leftCover && i<=rightCover) {
			covers.get(i).loadCoverImage();
		}
		else {
			covers.get(i).unloadCoverImage();
		}
	}	
}

/* -------------- ANIMATION  -------------- */
public void initCovers() 
{
	if(covers.size() > 0) {
	  covers.get(0).position.set(0.0 - 0.0, 0.0, 75.0);
	  covers.get(0).rotationY = 0.0;
	  for (int i=1; i<covers.size(); i++ ) {
	    covers.get(i).position.set(150.0 + 25.0*i, 0.0, 0.0);
	    covers.get(i).rotationY = -QUARTER_PI;
	  }
  }
}

public void moveCovers() 
{
  // left covers
  for (int i=0; i<selectedCover; i++ ) {
    Ani.to(covers.get(i).position, ANI_TIME, "x", -150.0 - 25.0*(selectedCover-i), Ani.CIRC_OUT);
    Ani.to(covers.get(i).position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
    Ani.to(covers.get(i).position, ANI_TIME, "z", 0.0, Ani.CIRC_OUT);
    Ani.to(covers.get(i), ANI_TIME, "rotationY", QUARTER_PI, Ani.CIRC_OUT);
  }

  // central cover
  coverAnimation = Ani.to(covers.get(selectedCover).position, 0.5, "x", 0.0, Ani.CIRC_OUT);
  Ani.to(covers.get(selectedCover).position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
  Ani.to(covers.get(selectedCover).position, ANI_TIME, "z", 75.0, Ani.CIRC_OUT);
  Ani.to(covers.get(selectedCover), ANI_TIME, "rotationY", 0.0, Ani.CIRC_OUT);

  // right covers
  for (int i=selectedCover + 1; i<covers.size(); i++ ) {
    Ani.to(covers.get(i).position, ANI_TIME, "x", 150.0 + 25.0*(i-selectedCover), Ani.CIRC_OUT);
    Ani.to(covers.get(i).position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
    Ani.to(covers.get(i).position, ANI_TIME, "z", 0.0, Ani.CIRC_OUT);
    Ani.to(covers.get(i), ANI_TIME, "rotationY", -QUARTER_PI, Ani.CIRC_OUT);
  }
}

