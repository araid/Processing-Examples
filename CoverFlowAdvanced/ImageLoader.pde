/**
 Advanced Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 */
import java.util.LinkedList;
import java.util.HashMap;

class ImageLoader
{
	LinkedList<String> queue;					// queue of images to load
	LinkedList<String> loadingImages;			// queue of images loading (maybe it's only one)
	HashMap<String, PImage> images;		// associative array of all loaded images
	
	ImageLoader() {
		 images = new HashMap<String, PImage>();
		 queue  = new LinkedList();
		 loadingImages = new LinkedList();
	}
	
	public boolean load(String name, PImage image) {
		// check if texture is loaded
		// check if texture is loading
		// check if we are keeping track of the texture already
		if (images.containsKey(name)) {
			println("image was already added to loader");			
			return false;
		}
		else {
			// add to image map
			images.put(name, image);			
			
			// add to queue
			queue.addLast(name);
			println("image added to loader");			
			
			return true;
		}
	}
	
	public boolean unload(String name) {
		// remove from map
		PImage image = images.get(name);
		if (image == null) {
			println("image couldn't be unloaded");
			return false;
		}
		else {
			println("image unloaded");
			
			image = null;
			images.remove(name);
			return true;
		}
	}
	
	public void update() {
		// check if images in loading queu finished loading
		for (String imageName : loadingImages) {
			PImage image = images.get(imageName);
			
			if (image == null) {
				// we unloaded that image, remove it from list
				loadingImages.remove(imageName);
				
				// load next image
				requestNextImage();
			}
			else if (image != null && image.width == -1) {
				// the image is still loading, don't do anything
			}
			else {
				// the image has finished loading
				println("image finished loading");
				
				// remove from loading queue
				loadingImages.remove(imageName);
				
				// load next image
				requestNextImage();
			}
		}
	}
	
	private void requestNextImage() {
		if (queue.size() > 0) {
			// should be a while, in case next image is not there
			String nextImageName = queue.getFirst();
			PImage image = images.get(nextImageName);
			
			if (image != null) {
				queue.removeFirst();
				loadingImages.addLast(nextImageName);
				image = requestImage(nextImageName);
				println("requesting image " + nextImageName);
			}
		}
	}
}