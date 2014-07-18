/**
 Quick Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 USING: 3D (openGL), events (controlp5) and animation (ani)
 */

import controlP5.*;
import de.looksgood.ani.*;

// Ui
ControlP5 controlP5;
Button bNext, bPrev;
Slider slider;

// Covers
Cover[] covers;
String[] names = { "00.jpg", "01.jpg", "02.jpg", "03.jpg", "04.jpg", "05.jpg", "06.jpg", "07.jpg", "08.jpg", "09.jpg", "10.jpg" };

// Graphics
PImage imgShadow;   
Ani coverAnimation;

int selectedCover = 0;
float ANI_TIME = 0.5;

/* -------------- INIT -------------- */
void setup() 
{
  size(800, 400, OPENGL);
  smooth();
  noStroke();

  imgShadow = loadImage("shadow.png");

  // Init interface controlP5
  controlP5 = new ControlP5(this);
  bPrev 	= controlP5.addButton("Prev",-1, 20, 360, 80, 20); 
  bNext 	= controlP5.addButton("Next", 1, width-100, 360, 80, 20);
  slider 	= controlP5.addSlider("slider", 0, names.length-1, selectedCover, 120, 360, width - 240, 20); 
  slider.setLabelVisible(false);

  // Init animation library Ani
  Ani.init(this);

  // Init covers
  covers = new Cover[names.length];
  for (int i=0; i<covers.length; i++) {
    covers[i] = new Cover(names[i]);
  }
  initCovers();
}

/* -------------- DRAW LOOP -------------- */
void draw() 
{
  background(0);
  hint(ENABLE_DEPTH_TEST);

  // move to the center to have easier coordinates
  pushMatrix();
  translate(width / 2, height / 2 ); 
  for( int i=0; i<covers.length; i++ ) {
    covers[i].drawCover();
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
  if (theEvent.controller().name() == "slider" ) {           // slider
    selectedCover = round(theEvent.controller().value());
  }
  else {                                                    // buttons
    selectedCover += (int) theEvent.controller().value();
    slider.setValue(selectedCover);
  }

  // Lock buttons if we are in the first or last cover
  if ( selectedCover == names.length ) {
    selectedCover --;
    bNext.lock();
  }
  else if ( selectedCover < 0 ) {
    selectedCover ++;
    bPrev.lock();
  }
  else {
    bNext.unlock();
    bPrev.unlock();
  }

  // Call Animation
  moveCovers();
}

/* -------------- ANIMATION  -------------- */
public void initCovers() 
{
  covers[0].position.set(0.0 - 0.0, 0.0, 75.0);
  covers[0].rotationY = 0.0;
  for (int i=1; i<covers.length; i++ ) {
    covers[i].position.set(150.0 + 25.0*i, 0.0, 0.0);
    covers[i].rotationY = -QUARTER_PI;
  }
}

public void moveCovers() 
{
  // left covers
  for (int i=0; i<selectedCover; i++ ) {
    Ani.to(covers[i].position, ANI_TIME, "x", -150.0 - 25.0*(selectedCover-i), Ani.CIRC_OUT);
    Ani.to(covers[i].position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
    Ani.to(covers[i].position, ANI_TIME, "z", 0.0, Ani.CIRC_OUT);
    Ani.to(covers[i], ANI_TIME, "rotationY", QUARTER_PI, Ani.CIRC_OUT);
  }

  // central cover
  coverAnimation = Ani.to(covers[selectedCover].position, 0.5, "x", 0.0, Ani.CIRC_OUT);
  Ani.to(covers[selectedCover].position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
  Ani.to(covers[selectedCover].position, ANI_TIME, "z", 75.0, Ani.CIRC_OUT);
  Ani.to(covers[selectedCover], ANI_TIME, "rotationY", 0.0, Ani.CIRC_OUT);

  // right covers
  for (int i=selectedCover + 1; i<covers.length; i++ ) {
    Ani.to(covers[i].position, ANI_TIME, "x", 150.0 + 25.0*(i-selectedCover), Ani.CIRC_OUT);
    Ani.to(covers[i].position, ANI_TIME, "y", 0.0, Ani.CIRC_OUT);
    Ani.to(covers[i].position, ANI_TIME, "z", 0.0, Ani.CIRC_OUT);
    Ani.to(covers[i], ANI_TIME, "rotationY", -QUARTER_PI, Ani.CIRC_OUT);
  }
}

