package mundovirtual.controller 
{
	import cepa.multiagent.actuator.ActuatorBase;
	import cepa.multiagent.actuator.IActuator;
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVAgent;
	import mundovirtual.model.MVAgentEvent;
	import mundovirtual.model.MVEnvironment;
	
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Act_Walk implements IActuator 
	{
		private var _dirX:int;
		private var _dirY:int;
		private var agent:Agent;
		private var time:Number;
		private var toY:int;
		private var toX:int;
		
		public function Act_Walk(a:Agent, toX:int, toY:int, time:Number)
		{			
			this.toX = toX;
			this.toY = toY;
			this.time = time;
			agent = a;
		}
		
		public function execute(agt:Agent):void 
		{
			var a:MVAgent = MVAgent(agent);
			a.environment.setAgentPosition(a, toX, toY);
			Actuate.timer(time * MV.velocity).ease(Linear.easeNone).onComplete(finish);

		}
		
		/* INTERFACE actuator.IActuator */
		
		public function finish():Boolean 		
		{
			agent.environment.eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_POSITION_REACHED, agent));
			return true;
			
		}
		
		/* INTERFACE actuator.IActuator */
		
		public function cancelOthers():Boolean 
		{
			return true;
			//return false;
		}
		
				
		public function get info():String 
		{
			return ""
		}
	
		
		public function get descr():String 
		{
			return "Andar para o ponto (DirX, DirY)"
		}
		
	
		public function get dirX():int 
		{
			return _dirX;
		}
		
		public function set dirX(value:int):void 
		{
			_dirX = value;
		}
		
		public function get dirY():int 
		{
			return _dirY;
		}
		
		public function set dirY(value:int):void 
		{
			_dirY = value;
		}
		
		
		
		
	}
	
}