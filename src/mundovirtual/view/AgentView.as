package mundovirtual.view 
{
	
	import flash.display.Bitmap;
	import mundovirtual.model.MVAgent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class AgentView extends Sprite 
	{
		[Embed(source = "agt.png")]
		protected var AgtPngImg:Class;
		
		private var agent:MVAgent;
		public function AgentView(agent:MVAgent) 
		{
			this.agent = agent;
			var im:Bitmap = new AgtPngImg();
			var tx:Texture = Texture.fromBitmap(im)
			var img:Image = new Image(tx);
			addChild(img);
			img.x = (- img.width / 2)+1;
			img.y = (-img.height/2)+1
		}
		
	}

}