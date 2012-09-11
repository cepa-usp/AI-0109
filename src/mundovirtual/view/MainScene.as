package mundovirtual.view 
{

	import cepa.multiagent.environment.Environment;
	import flash.display.Bitmap;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVEnvironment;
	import starling.display.Image;
	import starling.display.Sprite;
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

		public function MainScene() 
		{
			draw();
		}
		
		public function createScene(mv:MV):void {
			enviro = new EnvironmentView(mv.environment, 700, 600)
			enviro.setBackground(Bitmap(new ImgMainBg()));			
			addChild(enviro);
			addChild(labContainer);
			lab = new EnvironmentView(mv.lab, 185, 215);
			labContainer.addChild(lab);
			labContainer.x = 700 - 20
			labContainer.y = 100;
			
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