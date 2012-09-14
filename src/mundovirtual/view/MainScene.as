package mundovirtual.view 
{

	import cepa.multiagent.environment.Environment;
	import com.eclecticdesignstudio.motion.Actuate;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVEnvironment;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Arthur
	 */
	public class MainScene extends Sprite
	{
		private var _enviro:EnvironmentView;
		private var _lab:EnvironmentView;
		private var _labContainer:LabContainer = new LabContainer();
		
		[Embed(source = "environmt_img.png")]
		public static var ImgMainBg:Class;
		
		public const LABCONTAINER_X_CLOSED:int = 680;

		
		public function MainScene() 
		{
			draw();	
			
		}
		
		private function onLabTabTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage, TouchPhase.BEGAN);
			if (touch) {
				var position:Point = touch.getLocation(Image(e.target));				
				if(position.x<25) showLab(!labContainer.opened);
				
			}

			
		}
		
		public function showLab(value:Boolean):void {
			labContainer.opened = value;
			var toX:int = LABCONTAINER_X_CLOSED;
			if (labContainer.opened) {
				toX = this.stage.stageWidth - labContainer.width;
			} 
			trace(labContainer.width)
			Actuate.tween(labContainer, 1, {x:toX})
		}
				
		public function createScene(mv:MV):void {
			enviro = new EnvironmentView(mv.environment, 700, 600)
			enviro.setBackground(Bitmap(new ImgMainBg()));			
			addChild(enviro);
			addChild(labContainer);
			lab = new EnvironmentView(mv.lab, 185, 215);
			labContainer.addChild(lab);
			lab.x = 30;
			labContainer.x = LABCONTAINER_X_CLOSED;
			labContainer.y = 100;
			labContainer.addEventListener(TouchEvent.TOUCH, onLabTabTouch);
			
			
		}
		
		


		
		public function draw():void {
			//addChild(labContainer);
		}

		public function get enviro():EnvironmentView 
		{
			return _enviro;
		}
		
		public function set enviro(value:EnvironmentView):void 
		{
			_enviro = value;
		}
		
		public function get lab():EnvironmentView 
		{
			return _lab;
		}
		
		public function set lab(value:EnvironmentView):void 
		{
			_lab = value;
		}
		
		public function get labContainer():LabContainer 
		{
			return _labContainer;
		}
		
		public function set labContainer(value:LabContainer):void 
		{
			_labContainer = value;
		}
		
		
	}

}