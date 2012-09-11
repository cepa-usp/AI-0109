package mundovirtual.view 
{
	
	import flash.display.Bitmap;
	import mundovirtual.model.MVAgent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class AgentView extends Sprite 
	{
		[Embed(source = "AI-0109arte.png")]
		public static var AgtPngImg:Class;
		
		[Embed(source = "AI-0109arte.xml", mimeType="application/octet-stream")]
		public static var AgtPngXml:Class;		
		
		public static var textAtlas:TextureAtlas = null;		
		private var agent:MVAgent;
		
		
		public static function getPic(picname:String):Image {
			if (AgentView.textAtlas == null) createTextures();
			var img:Image = new Image(AgentView.textAtlas.getTexture(picname));		
			return img;			
		}
		
		public static function createTextures():void {
			var im:Bitmap = new AgtPngImg();
			var tx:Texture = Texture.fromBitmap(im)
			var xml:XML = XML(new AgtPngXml());			
			AgentView.textAtlas = new TextureAtlas(tx, xml)			
		}
		
		public function calculatePicName():String {			
			var symbNames:Array = ["Copas", "Espadas", "Ouros", "Paus"]
			var shapeNames:Array = ["cir", "tri", "qua", "pen"]
			var colorNames:Array = ["azul", "lar", "v", "ver"]
			var name:String = symbNames[agent.symbol] + shapeNames[agent.shape] + colorNames[agent.color] + "0000";
			return name;
		}
		
		public function AgentView(agent:MVAgent) 
		{
			this.agent = agent;
			var img:Image = getPic(calculatePicName());
			addChild(img);
			img.x = (- img.width / 2)+1;
			img.y = (-img.height/2)+1
		}
		
	}

}