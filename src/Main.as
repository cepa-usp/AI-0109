package 
{
	import cepa.ai.AI;
	import cepa.ai.AIInstance;
	import cepa.ai.AIObserver;
	import cepa.ai.IPlayInstance;
	import cepa.tutorial.CaixaTexto;
	import cepa.tutorial.Tutorial;
	import cepa.tutorial.TutorialEvent;
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
	public class Main extends Sprite implements AIInstance, AIObserver 
	{

		private var mainScene:MainScene;
		private var plainStageSprite:Sprite = new Sprite();
		private var qtAgents:int = 20;
		private var mv:MV;
		private var tut:Tutorial;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		/* INTERFACE cepa.ai.AIObserver */
		
		public function onResetClick():void 
		{
			reset();
		}
		
		private function reset():void 
		{
			if (mv != null) mv.clear();
			mv.createAgents(qtAgents);
			mv.start();
		}
		
		public function onScormFetch():void 
		{
			
		}
		
		public function onScormSave():void 
		{
			
		}
		
		public function onStatsClick():void 
		{
			
		}
		
		public function onTutorialClick():void 
		{
			createTutorial();
		}
		
		public function onScormConnected():void 
		{
			
		}
		
		public function onScormConnectionError():void 
		{
			
		}
		
		/* INTERFACE cepa.ai.AIInstance */
		
		public function getData():Object 
		{
				return new Object()
		}
		
		public function readData(obj:Object) 
		{
			
		}
		
		public function createNewPlayInstance():IPlayInstance 
		{
			return null;
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
		
		private function createTutorial():void {
			if (tut!=null) {
				if (tut.state == Tutorial.STATE_RUNNING) return;
			}
			mv.pause();
			tut = new Tutorial();
			var str:Array = ["Veja as orientações aqui.", "Cada uma dessas peças representa um elemento que compõe este Mundo Virtual.", "Utilize o laboratório para analisar como os elementos interagem entre si: arraste um ou mais para cá."]
			tut.addEventListener(TutorialEvent.FIM_TUTORIAL, onTutorialEnd);
			tut.addEventListener(TutorialEvent.BALAO_ABRIU, onBalaoAbriu);
			
			tut.adicionarBalao(str[0], new Point(600, 450), CaixaTexto.RIGHT, CaixaTexto.CENTER);
			tut.adicionarBalao(str[1], new Point(350, 250), -1, -1);
			tut.adicionarBalao(str[2], new Point(400, 290), CaixaTexto.RIGHT, CaixaTexto.CENTER);
			posIniLab = mv.lab.visible;
			tut.iniciar(this.stage);
		}
		private var posIniLab:Boolean = false;
		private function onBalaoAbriu(e:TutorialEvent):void 
		{
			switch(e.numBalao) {
				case 2:
					mv.showLab(true);
					
			}
		}
		
		private function onTutorialEnd(e:TutorialEvent):void 
		{
			mv.play();
			mv.showLab(posIniLab);
			
		}
		
		
		private function onContextCreated(e:flash.events.Event):void 
		{
			addChild(plainStageSprite);
			mainScene = Starling.current.stage.getChildAt(0) as MainScene;
			mainScene.plainStageSprite = plainStageSprite;
			mv = new MV();
			mainScene.createScene(mv);
					
			var envController:EnvironmentController = new EnvironmentController(mv.environment, mainScene.enviro)
			var labController:EnvironmentController = new EnvironmentController(mv.lab, mainScene.lab)			
			var agController:AgentDragController = new AgentDragController(mv, mainScene);
			var mainSceneController:MainSceneController = new MainSceneController(mainScene, mv);
			var ai:AI = new AI(this);
			ai.addObserver(this)
			ai.container.setAboutScreen(new AboutScreen109());
			ai.container.setInfoScreen(new InfoScreen109())
			ai.container.removeButton("btStatistics");
			ai.container.setMessageTextVisible(false);
			
			
			mv.createAgents(qtAgents);
			mv.start();
		}
		
	
		
		

		
		
	}
	
}