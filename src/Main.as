package 
{
	import cepa.ai.AI;
	import flash.display.Sprite;
	import flash.events.Event;
	import mundovirtual.controller.AgentDragController;
	import mundovirtual.controller.EnvironmentController;
	import mundovirtual.model.MV;
	import mundovirtual.view.EnvironmentView;
	import mundovirtual.view.MainScene;
	import starling.events.Event;
	import starling.core.Starling;
	

	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Main extends Sprite 
	{

		private var mainScene:MainScene;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:flash.events.Event=null):void 
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			var star:Starling = new Starling(MainScene, stage);
			star.stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onContextCreated);
			star.start();
			
			
			
		}
		
		private function onContextCreated(e:flash.events.Event):void 
		{
			mainScene = Starling.current.stage.getChildAt(0) as MainScene;
			var mv:MV = new MV();
			mainScene.createScene(mv);
					
			var envController:EnvironmentController = new EnvironmentController(mv.environment, mainScene.enviro)
			var labController:EnvironmentController = new EnvironmentController(mv.lab, mainScene.lab)
			var agController:AgentDragController = new AgentDragController(mv, mainScene);
			var ai:AI = new AI(this);
			
			
			mv.createAgents();
			mv.start();
		}
		
	
		
		

		
		
	}
	
}