package mundovirtual.view 
{
	import starling.events.Event;
	
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class EnviroViewEvent extends Event 
	{
		private var _environment:EnvironmentView;
		private var _agent:AgentView;
		
		public static const AGENT_CREATED:String = "AgentCreated";
		public static const AGENT_BEGIN_DRAG:String = "AgentBeginDrag";
		public static const AGENT_END_DRAG:String = "AgentBeginDrag";
		
		public function EnviroViewEvent(env:EnvironmentView, ag:AgentView, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.agent = ag;
			this.environment = env;
			
		} 

		
		public override function toString():String 
		{ 
			return "EnviroViewEvent";
		}
		
		public function get agent():AgentView 
		{
			return _agent;
		}
		
		public function set agent(value:AgentView):void 
		{
			_agent = value;
		}
		
		public function get environment():EnvironmentView 
		{
			return _environment;
		}
		
		public function set environment(value:EnvironmentView):void 
		{
			_environment = value;
		}
		
	}
	
}