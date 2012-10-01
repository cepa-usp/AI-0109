package 
{
	import cepa.ai.AI;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import mundovirtual.controller.AgentDragController;
	import mundovirtual.controller.EnvironmentController;
	import mundovirtual.controller.MainSceneController;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVEnvironment;
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
		private var plainStageSprite:Sprite = new Sprite();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:flash.events.Event=null):void 
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			//testLaws()
			//return;
			var star:Starling = new Starling(MainScene, stage);
			star.stage3D.addEventListener(starling.events.Event.CONTEXT3D_CREATE, onContextCreated);
			star.start();
			
			
			
		}

		private function testLaws():void {
			
			var env:MVEnvironment = new MVEnvironment(10, 10);
			
			for (var i:int = 0; i <= 3; i++) {
				for (var j:int = 0; j <= 3; j++) {
					var p:Point = env.findMatrixValues(i, j)
					trace(i, j, p, env.wrapPoint(p));
				}
			}

		}
		
		private function onContextCreated(e:flash.events.Event):void 
		{
			addChild(plainStageSprite);
			mainScene = Starling.current.stage.getChildAt(0) as MainScene;
			mainScene.plainStageSprite = plainStageSprite;
			var mv:MV = new MV();
			mainScene.createScene(mv);
					
			var envController:EnvironmentController = new EnvironmentController(mv.environment, mainScene.enviro)
			var labController:EnvironmentController = new EnvironmentController(mv.lab, mainScene.lab)			
			var agController:AgentDragController = new AgentDragController(mv, mainScene);
			var mainSceneController:MainSceneController = new MainSceneController(mainScene, mv);
			var ai:AI = new AI(this);
			ai.container.setMessageTextVisible(false);
			
			
			mv.createAgents();
			mv.start();
		}
		
	
		
		

		
		
	}
	
}