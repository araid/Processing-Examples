/**
 Advanced Cover Flow in Processing
 by Adrià Navarro http://adrianavarro.net 
 */
import java.util.LinkedList;
import java.util.HashMap;

class ImageLoader
{
	static final int MAX_LOADING_IMAGES = 2;
	LinkedList<String> queue;					// queue of images to load
	/*LinkedList<String> loadingImages;			// queue of images loading (maybe it's only one)*/
	HashMap<String, PImage> loadedImages;		// associative array of all loaded images
	HashMap<String, PImage> loadingImages;		// associative array of all loaded images
	
	PImage defaultImage;
	
	ImageLoader() {
		 loadedImages  = new HashMap<String, PImage>();
		 loadingImages = new HashMap<String, PImage>();
		 queue  = new LinkedList();
		 defaultImage = new PImage();
		 /*loadingImages = new LinkedList();*/
	}
	
	public boolean load(String name) {
		// check if texture is loaded
		// check if texture is loading
		// check if we are keeping track of the texture already
		if (loadedImages.containsKey(name) ||
			loadingImages.containsKey(name) ||
			queue.contains(name)) {
				
			println("image was already added to loader");			
			return false;
			/*return null;*/
		}
		else {
			// add to image map
			/*PImage image = new PImage();*/
			/*images.put(name, image);			*/
			
			// add to queue
			queue.addLast(name);
			println("image added to loader");			
			
			return true;
			/*return image;*/
		}
	}
	
	public boolean unload(String name) {
		// remove from map
		/*if (images.containsKey(name)) {
			PImage image = images.get(name);
			image = null;
			images.remove(name);
			println("image unloaded");
			return true;
		}
		else {
			println("image couldn't be unloaded");
			return false;
		}*/
			loadingImages.remove(name);
			loadedImages.remove(name);
			queue.remove(name);
			
			return true;
	}
	
	public PImage getImage(String fileName) {
		
		if (loadedImages.containsKey(fileName)) {
			return loadedImages.get(fileName);
		}
		else {
			return defaultImage;
		}
	}
	
	public void update() {
		// check if images in loading queu finished loading
		/*for (String imageName : loadingImages) {
			println("processing loadingImage " + imageName);
			boolean doneLoading = false;

			if (images.containsKey(imageName)) {
				PImage image = images.get(imageName);
				if (image != null && image.width != -1) {
					// image finished loading
					doneLoading = true;
				}
			}
			else {
				// image was unloaded
				doneLoading = true;
			}

			if (doneLoading) {
				// remove it from list
				println("removing image from loading list: " + imageName);
				loadingImages.remove(imageName);
			}
		}*/
			
		for(String imageName : loadingImages.keySet()) {
		    PImage image = loadingImages.get(imageName);

			if (image != null && image.width != -1) {
				// image finished loading
				println("removing image from loading list: " + imageName);
				loadingImages.remove(imageName);
				loadedImages.put(imageName, image);
			}

		}
		
		// start loading more images
		while(loadingImages.size() < MAX_LOADING_IMAGES && queue.size() > 0) {
			println("request next image");
			requestNextImage();
		}
	}
	
	private void requestNextImage() {
		if (queue.size() > 0) {
			String nextImageName = queue.pollFirst();
			
			/*if (images.containsKey(nextImageName)) {*/
			
			/*PImage image = images.get(nextImageName);*/
			/*queue.removeFirst();*/
			/*loadingImages.addLast(nextImageName);*/
			/*image = requestImage(nextImageName);*/
			/*image = loadImage(nextImageName);*/
			/*loadingImages.put(nextImageName, requestImage(nextImageName));*/
			loadingImages.put(nextImageName, loadImage(nextImageName));
			println("requesting image " + nextImageName);
			/*}*/
		}
	}
}