package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class MVAgentEvent extends AgentEvent 
	{
		private var _collidedWith:Agent = null;
		
		static public const AGENT_COLLIDED:String = "agentCollided";
		static public const AGENT_VELOCITY_CHANGED:String = "agentVelocityChanged";
		static public const AGENT_TRANSFORMED:String = "agentTransformed";
		static public const SEEK_FINISHED:String = "seekFinished";
		
		public function MVAgentEvent(agt:Agent, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, agt, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MVAgentEvent(agent, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WalkEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		

		
		public function get collidedWith():Agent 
		{
			return _collidedWith;
		}
		
		public function set collidedWith(value:Agent):void 
		{
			_collidedWith = value;
		}
		
	}
	
}