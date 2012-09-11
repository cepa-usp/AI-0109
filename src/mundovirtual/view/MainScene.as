package mundovirtual.view 
{

	import cepa.multiagent.environment.Environment;
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
		private var _labContainer:Sprite = new Sprite();
		

		public function MainScene() 
		{
			draw();
		}
		
		public function createScene(mv:MV):void {
			enviro = new EnvironmentView(mv.environment, 800, 600)
			addChild(enviro);
		}
		


		
		public function draw():void {
			addChild(labContainer);
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
		
		public function get labContainer():Sprite 
		{
			return _labContainer;
		}
		
		public function set labContainer(value:Sprite):void 
		{
			_labContainer = value;
		}
		
		
	}

}