/**
 Advanced Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 */
import java.util.LinkedList;
import java.util.HashMap;

class ImageLoader
{
	LinkedList<String>  queue;					// queue of images to load
	LinkedList<String>  loadingQueue;			// queue of images loading (maybe it's only one)
	HashMap<String, PImage> images;		// associative array of all loaded images
	
	ImageLoader() {
		 loadedImages = new HashMap<String, PImage>();
	}
	
	public void load(String name) {
		// check if texture is loaded
		
		// check if texture is loading
		
		
		// add to loading queue
	}
	
	public void unload(String name) {
		// remove from map
	}
	
	public void update() {
		// check if images in loading queu are loaded
		
		// if they are, add to actually loading queue
	}
}