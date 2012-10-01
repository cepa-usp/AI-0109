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
		private var _layerDragArea:Sprite = new Sprite();
		private var _layerLabs:Sprite = new Sprite();
		private var _plainStageSprite:flash.display.Sprite;
		private var _playControl:PlayCtrl;
		
		[Embed(source = "environmt_img2.jpg")]
		public static var ImgMainBg:Class;
		
		public const LABCONTAINER_X_CLOSED:int = 670;
		public const LABCONTAINER_X_OPENED:int = 470;

		
		public function MainScene() 
		{
			draw();	
			
		}
		
		private function onLabTabTouch(e:TouchEvent):void 
		{
			if (!(Image(e.target).parent is LabContainer)) {
				return;
			}
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
				toX = LABCONTAINER_X_OPENED;
				
			} 
			
			Actuate.tween(labContainer, 1, {x:toX})
		}
				
		public function createScene(mv:MV):void {
			layerLabs.name = "layerLabs";
			layerDragArea.name = "layerDragArea";
			addChild(layerLabs);
			enviro = new EnvironmentView(mv.environment, 700, 600)
			enviro.name = "DefaultEnvironmentView";
			enviro.setBackground(Bitmap(new ImgMainBg()));			
			layerLabs.addChild(enviro);
			layerLabs.addChild(labContainer);
			lab = new EnvironmentView(mv.lab, 185, 215);
			lab.name = "LabEnvironmentView";
			labContainer.addChild(lab);
			labContainer.name = "LabContainer";
			lab.x = 30;
			labContainer.x = LABCONTAINER_X_CLOSED;
			labContainer.y = 100;
			labContainer.addEventListener(TouchEvent.TOUCH, onLabTabTouch);
			addChild(layerDragArea);
			createPlayControl();
		}
		
		private function createPlayControl():void 
		{
			playControl = new PlayCtrl();
			plainStageSprite.addChild(playControl);
			playControl.x = 20;
			playControl.y = 20;			
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
		
		public function get layerDragArea():Sprite 
		{
			return _layerDragArea;
		}
		
		public function set layerDragArea(value:Sprite):void 
		{
			_layerDragArea = value;
		}
		
		public function get layerLabs():Sprite 
		{
			return _layerLabs;
		}
		
		public function set layerLabs(value:Sprite):void 
		{
			_layerLabs = value;
		}
		
		public function get plainStageSprite():flash.display.Sprite 
		{
			return _plainStageSprite;
		}
		
		public function set plainStageSprite(value:flash.display.Sprite):void 
		{
			_plainStageSprite = value;
		}
		
		public function get playControl():PlayCtrl 
		{
			return _playControl;
		}
		
		public function set playControl(value:PlayCtrl):void 
		{
			_playControl = value;
		}
		
		
	}

}