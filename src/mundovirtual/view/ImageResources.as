package mundovirtual.view 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Arthur
	 */
	public class ImageResources 
	{
		
		public function ImageResources() 
		{
			

		}
		
		public static function addImageToStarlingSprite(bmp:Bitmap, spr:Sprite):void {
			var tx:Texture = Texture.fromBitmap(bmp)
			spr.addChild(new Image(tx));				
		}
		
			
		
	}

}