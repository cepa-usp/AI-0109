package mundovirtual.controller 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.environment.Environment;
	import cepa.multiagent.environment.EnvrPosition;
	import cepa.multiagent.reasoning.IReasoning;
	import mundovirtual.view.LabContainer;
	import starling.display.DisplayObject;
	
	import flash.geom.Point;
	import mundovirtual.model.MVAgentEvent;
	import mundovirtual.view.AgentView;
	import mundovirtual.view.EnvironmentView;
	import mundovirtual.view.EnviroViewEvent;
	import mundovirtual.view.MainScene;
	import mundovirtual.model.MV;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author Arthur
	 */
	public class AgentDragController 
	{
		static public const STATE_STOPPED:int = 0;
		static public const STATE_DRAGGING:int = 1;
		
		private var mv:MV;
		private var mainScene:MainScene;
		private var dragAgent:AgentView;
		private var _state:int = AgentDragController.STATE_STOPPED
		
		public function AgentDragController(mv:MV, mainScene:MainScene) 
		{
			this.mainScene = mainScene;
			this.mv = mv;
			mainScene.lab.addEventListener(EnviroViewEvent.AGENT_CREATED, onAgentCreated);
			mainScene.enviro.addEventListener(EnviroViewEvent.AGENT_CREATED, onAgentCreated);
		}
		
		private function onAgentCreated(e:EnviroViewEvent):void 
		{
				//if (!(e.target is AgentView)) return;	
				var a:AgentView = e.agent;
				a.addEventListener(TouchEvent.TOUCH, onAgentTouch)
		}
		
		private function onAgentTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(mainScene);
			var position:Point = touch.getLocation(mainScene);			
			
			if (this._state == AgentDragController.STATE_STOPPED) {
				if (touch.phase == TouchPhase.BEGAN) {
				//	trace("pegou")
					state = AgentDragController.STATE_DRAGGING;
					dragAgent = AgentView(Image(e.target).parent);
					dragAgent.agent.state = Agent.STATE_PAUSED;
					
					for each(var r:IReasoning in dragAgent.agent.reasoning) {
						r.cancel();
					}
					
					for each (var ep:EnvrPosition in dragAgent.agent.environment.positions) {
						if (ep.agentHere == dragAgent.agent) {
							ep.agentHere = null;
							dragAgent.agent.positionX = -1;
							dragAgent.agent.positionY = -1;
						}
					}
					dragAgent.parent.removeChild(dragAgent);
					mainScene.layerDragArea.addChild(dragAgent);
					dragAgent.x = position.x// - dragAgent.width/2;
					dragAgent.y = position.y// - dragAgent.height/2;					
				} 
			} else if (this.state == AgentDragController.STATE_DRAGGING) {
				if(touch.phase == TouchPhase.MOVED ){
					dragAgent.x = position.x// - dragAgent.width/2;
					dragAgent.y = position.y// - dragAgent.height/2;
				} else if (touch.phase == TouchPhase.ENDED) {
					//trace("soltou")					
					state = AgentDragController.STATE_STOPPED
					calculateNewPosition(dragAgent, position)
					
					if(!mv.paused) dragAgent.agent.run();
					dragAgent = null;
				}
			}
			
			

   

		}
		
		private function findEnviro(o:DisplayObject):EnvironmentView {
			if (o == null) return null;
			if (o is EnvironmentView) return EnvironmentView(o);
			if (o is LabContainer) return EnvironmentView(LabContainer(o).getChildByName("LabEnvironmentView"));
			return findEnviro(o.parent);
			
		}
		
		
		private function calculateNewPosition(ag:AgentView, pos:Point):void 
		{
			// calculate environment
			var o:Object = mainScene.layerLabs.hitTest(pos);
			var env:EnvironmentView = null;
			if (o != null) {
				if (o is Image) {
					env = findEnviro(Image(o));
					//trace(env);
				}
			}
			mainScene.layerDragArea.removeChild(ag);
			
			var possibleModelPosition:Point = env.getNearestModelPosition(pos);
			var posvai:Point = env.environment.findNearestFreePosition(possibleModelPosition);
			//trace(pos, possibleModelPosition, posvai);
			if (env != null) {
				ag.agent.environment.unRegisterAgent(ag.agent);
				env.environment.registerAgent(ag.agent, posvai.x, posvai.y);
			}
			
			// calculate position
			// encontrar a posicao equivalente
			
			// encontrar a posicao mais próxima válida
			
		}

		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			_state = value;
		}
		
		
	}

}