package mundovirtual.view 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.system.ImageDecodingPolicy;
	import flash.utils.Dictionary;
	import mundovirtual.model.MVAgent;
	import mundovirtual.model.MVEnvironment;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Arthur
	 */
	public class EnvironmentView extends Sprite
	{
		private var environment:MVEnvironment;
		private var layerAgents:Sprite = new Sprite();
		private var layerBg:Sprite = new Sprite();
		private var agents:Dictionary = new Dictionary();
		private var w:int;
		private var h:int;
		private var offsetX:int;
		private var offsetY:int;
		
		public function setOffset(off_x:int, off_y:int):void {
			this.offsetX = off_x;
			this.offsetY = off_y;
		}
		
		
		public function draw():void {
			if(w>200) return;
			
			var shape:flash.display.Sprite = new flash.display.Sprite();
			var color:uint = 0xFFFFFF;
			shape.graphics.beginFill(color, 0.01);			
			shape.graphics.drawRect(0, 0, w, h);			
			shape.graphics.endFill();
			shape.graphics.lineStyle(1, 0xFF8040, 0.8);
			var distX:int = w / environment.width;
			var distY:int = h / environment.height;
			var w_ini:int = distX/2;
			var h_ini:int = distY/2;
			var w_fim:int = w - w_ini;			
			var h_fim:int = h - h_ini;
			
			for (var xx:int = 0; xx < environment.width; xx++) {
				shape.graphics.moveTo(w_ini + distX*xx, h_ini)
				shape.graphics.lineTo(w_ini + distX*xx, h_fim)
			}
			for (var yy:int = 0; yy < environment.height; yy++) {
				shape.graphics.moveTo(w_ini, h_ini + distY*yy)
				shape.graphics.lineTo(w_fim,  h_ini + distY*yy)

			}

			
			var bmd:BitmapData = new BitmapData(w, h, true, color);
			bmd.draw(shape)
			var texture:Texture = Texture.fromBitmapData(bmd);
			var image:Image = new Image(texture);
			addChild(image);
			
		}
		
		public function addLayers():void {
			addChild(layerBg);
			addChild(layerAgents);
		}
		
		public function EnvironmentView(environment:MVEnvironment, w:int, h:int) 
		{
			this.h = h;
			this.w = w;
			this.environment = environment;			
			addLayers();
			draw();
			
		}
		
		public function setBackground(img:Bitmap):void {
			var tx:Texture = Texture.fromBitmap(img)
			layerBg.addChild( new Image(tx));
		}
		
		public function createAgent(agent:MVAgent):void 
		{
			var av:AgentView = new AgentView(agent);
			layerAgents.addChild(av);
			agents[agent] = av;
			//av.scaleX = 0.8;
			//av.scaleY = 0.8;
			scaleAgent(av)
			setAgentPosition(agent, agent.positionX, agent.positionY, false);
			
			
		}
		
		public function scaleAgent(a:AgentView):Number {
			var p:Point = new Point(0, 0);
			var distX:Number = (w / environment.width);
			//var distY:Number = h / environment.height;
			var scl:Number = distX/a.width ;
			a.scaleX = scl;
			a.scaleY = scl;
			return scl
		}
		
		
		/**
		 * Returns the position in pixels given a location of an agent
		 * @param	posX
		 * @param	posY
		 * @return
		 */
		public function getPosition(posX:int, posY:int):Point {
			var distX:int = w / environment.width;
			var distY:int = h / environment.height;
			var w_ini:int = distX/2 + offsetX;
			var h_ini:int = distY/2 + offsetY;
			return new Point((distX * posX) + w_ini, (distY * posY) + h_ini);
			
		}
		

		/**
		 * Changes an agent's position according to a given location
		 * @param	a
		 * @param	posX
		 * @param	posY
		 */
		public function setAgentPosition(a:MVAgent, posX:int, posY:int, animate:Boolean = true):void {
			if (agents[a] == null) {
				throw new Error("Can't set position on a null agent")
			}
			var av:AgentView = AgentView(agents[a]);
			var pos:Point = getPosition(posX, posY);			
			if (animate) {
				Actuate.tween(av, calculateDuration(a, pos), { x:pos.x, y:pos.y } ).ease(Linear.easeNone);
			} else {
				av.x = pos.x;
				av.y = pos.y;
			}
			
		}
		
		public function calculateDuration(a:MVAgent, pos:Point):Number 
		{
			var distX:Number = w / environment.width;
			var distY:Number = h / environment.height;
			var distUnit:Number;
			if (a.direction.x == 0) {
				// vertical
				distUnit = distY;
			} else {
				// horizontal
				distUnit = distX;
			}

			var dist:Number = Point.distance(new Point(AgentView(agents[a]).x, AgentView(agents[a]).y), pos)/distUnit;
			var vel:Number = a.velocity;
			var dur:Number = dist / vel
			return dur;
		}	
		
	}

}