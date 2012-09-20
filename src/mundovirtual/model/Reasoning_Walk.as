package mundovirtual.model 
{
	import cepa.multiagent.actuator.IActuator;
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.environment.EnvironmentEvent;
	import cepa.multiagent.reasoning.IReasoning;
	import flash.geom.Point;
	import mundovirtual.controller.Act_Seek;
	import mundovirtual.controller.Act_Walk;
	/**
	 * ...
	 * @author Arthur
	 */
	public class Reasoning_Walk implements IReasoning
	{
		public static const STATE_STOPPED:int = 0;
		public static const STATE_WALKING:int = 1;
		public static const STATE_SEEK:int = 2;
		
		public static const DIRECTION_UP:Point = new Point(0, -1);
		public static const DIRECTION_DOWN:Point = new Point(0, 1);
		public static const DIRECTION_LEFT:Point = new Point(-1, 0);
		public static const DIRECTION_RIGHT:Point = new Point(1, 0);
		
		

		private var walkto:Point;
		private var agt:MVAgent;
		private var direction:Point;
		private var seekTime:Number = 0.3;
		private var _movementState:int = Reasoning_Walk.STATE_STOPPED;
		
		public function Reasoning_Walk(agt:MVAgent) 
		{
			this.agt = agt;
			agt.environment.eventDispatcher.addEventListener(AgentEvent.MOVEMENT_STATE_CHANGED, onMovementChanged);
			agt.environment.eventDispatcher.addEventListener(AgentEvent.AGENT_MOVEMENT_ALLOWED, onMovementAllowed);
			agt.environment.eventDispatcher.addEventListener(AgentEvent.AGENT_MOVEMENT_DENIED, onMovementDenied);			
			agt.environment.eventDispatcher.addEventListener(MVAgentEvent.AGENT_COLLIDED, onCollided);
			agt.environment.eventDispatcher.addEventListener(MVAgentEvent.SEEK_FINISHED, onSeekFinished);
			agt.environment.eventDispatcher.addEventListener(AgentEvent.AGENT_POSITION_REACHED, onPositionReached);
			agt.environment.eventDispatcher.addEventListener(MVAgentEvent.AGENT_TRANSFORMED, onTransformed);
			
			
		}
		
		private function onTransformed(e:MVAgentEvent):void 
		{
			if (e.agent == agt) {
				agt.direction= null;
				chooseDirection();
			}
		}
		
		private function onCollided(e:MVAgentEvent):void 
		{
			//if (e.collidedWith == agt || e.agent) {
//				agt.direction = null;
				//chooseDirection();
				//movementState = Reasoning_Walk.STATE_SEEK;
			//}
		}
		
		
		private function onPositionReached(e:AgentEvent):void 
		{
			if(e.agent==this.agt) this.process(this.agt);
		}
		
		private function onSeekFinished(e:MVAgentEvent):void 
		{
				if(e.agent==this.agt) this.process(this.agt);
		}

		private function onMovementDenied(e:AgentEvent):void 
		{
			if (e.agent == this.agt) {
				e.stopPropagation();
				movementState = Reasoning_Walk.STATE_SEEK;				
			}			
		}
		
		private function onMovementAllowed(e:AgentEvent):void 
		{
			if (e.agent == this.agt) {
				e.stopPropagation();				
				walkto = new Point(e.walkX, e.walkY);
				movementState = Reasoning_Walk.STATE_WALKING;
			}
			
		}
		
		private function onMovementChanged(e:AgentEvent):void 
		{
			if (e.agent == this.agt) {
				switch(movementState) {
					case STATE_SEEK:
						// waits a bit before continue
						changeDirection();
						//trace("mudou dir do ", agt.uid);
						var seek:Act_Seek = new Act_Seek(this.agt);
						seek.execute(agt);
						break;
					case STATE_WALKING:
						//1. tenta ir para o lado que já está indo						
						var toX:int = walkto.x;
						var toY:int = walkto.y;
						var time:Number = Point.distance(new Point(agt.positionX, agt.positionY), new Point(toX, toY))/agt.velocity;
						var walk:Act_Walk = new Act_Walk(this.agt, toX, toY, time);
						//trace(agt.uid, toX, toY)
						walk.execute(agt);
						
						break;
				}
				walkto = null;
				
			}
			
		}
	
		
		
		/* INTERFACE cepa.multiagent.reasoning.IReasoning */
		
		public function get description():String 
		{
			if(agt==null) return "Agt - walking"
			return "Agt #" + agt.uid + "  - walking";
		}
		
		public function get isDeterministic():Boolean 
		{
			return false;
		}
		
		public function get movementState():int 
		{
			return _movementState;
		}
		
		public function set movementState(value:int):void 
		{
			_movementState = value;
			agt.environment.eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.MOVEMENT_STATE_CHANGED, agt));
		}
		
		public function process(agt:Agent):void 		
		{	
			if (agt.state == Agent.STATE_PAUSED) return;
			if (movementState == STATE_STOPPED) chooseDirection();			
			var ev:AgentEvent = new AgentEvent(AgentEvent.MOVE_REQUEST, this.agt);
			ev.walkX = agt.positionX + agt.direction.x;
			ev.walkY = agt.positionY + agt.direction.y


			agt.environment.eventDispatcher.dispatchEvent(ev);	
		}
		
		/* INTERFACE cepa.multiagent.reasoning.IReasoning */
		
		public function cancel():void
		{
			agt.environment.eventDispatcher.removeEventListener(AgentEvent.MOVEMENT_STATE_CHANGED, onMovementChanged);
			agt.environment.eventDispatcher.removeEventListener(AgentEvent.AGENT_MOVEMENT_ALLOWED, onMovementAllowed);
			agt.environment.eventDispatcher.removeEventListener(AgentEvent.AGENT_MOVEMENT_DENIED, onMovementDenied);			
			agt.environment.eventDispatcher.removeEventListener(MVAgentEvent.SEEK_FINISHED, onSeekFinished);
			agt.environment.eventDispatcher.removeEventListener(MVAgentEvent.AGENT_COLLIDED, onCollided);
			agt.environment.eventDispatcher.removeEventListener(AgentEvent.AGENT_POSITION_REACHED, onPositionReached);			
			agt.environment.eventDispatcher.addEventListener(MVAgentEvent.AGENT_TRANSFORMED, onTransformed);
			this.agt.removeReasoning(this);
			this.agt = null;
			
		}
		
		
		private function chooseDirection():void 
		{
			if (agt.direction != null) return;
			if (agt.color < 2) {
				agt.direction = DIRECTION_DOWN.clone();
			} else {
				agt.direction = DIRECTION_RIGHT.clone();
			}
			
		}
		
		private function changeDirection():void {
			agt.direction.x *= -1;
			agt.direction.y *= -1;
			//trace("mudou a direcao de ", agt.uid);
		}
		

//		private function checkRelativePos(x:int, y:int):Boolean {
//			var o:Object = agt.environment.pos[agt.positionX + x][agt.positionY + y];
			//if(o!=null)
			
//		}
		
	}

}