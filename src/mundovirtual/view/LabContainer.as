package mundovirtual.view 
{
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Arthur
	 */
	public class LabContainer extends Sprite
	{
		[Embed(source = "lab_img.png")]
		public static var LabImg:Class;
		private var _opened:Boolean = false;
	
		public function LabContainer() 
		{
			ImageResources.addImageToStarlingSprite(Bitmap(new LabImg()), this);
		
		}
		
		public function get opened():Boolean 
		{
			return _opened;
		}
		
		public function set opened(value:Boolean):void 
		{
			_opened = value;
		}
		

	}

}