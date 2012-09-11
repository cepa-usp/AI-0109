package mundovirtual.view 
{
	import flash.display.Bitmap;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Arthur
	 */
	public class LabContainer extends Sprite
	{
		[Embed(source = "lab_img.png")]
		public static var LabImg:Class;
	
		public function LabContainer() 
		{
			ImageResources.addImageToStarlingSprite(Bitmap(new LabImg()), this);
		}
		
	}

}