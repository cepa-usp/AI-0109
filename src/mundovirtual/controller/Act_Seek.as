package mundovirtual.controller 
{
	import cepa.multiagent.actuator.IActuator;
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import mundovirtual.model.MV;
	import mundovirtual.model.MVAgent;
	import mundovirtual.model.MVAgentEvent;
	/**
	 * ...
	 * @author Arthur
	 */
	public class Act_Seek implements IActuator
	{
		private var agt:MVAgent;
		private var seektime:Number = 0.4;
		
		public function Act_Seek(agt:MVAgent) 
		{
			this.agt = agt;
			
		}
		
		/* INTERFACE cepa.multiagent.actuator.IActuator */
		
		public function get descr():String 
		{
			return "seeking for a new position";
		}
		
		public function get info():String 
		{
			return "seek";
		}
		
		public function execute(agt:Agent):void 
		{
			Actuate.timer(seektime * MV.velocity).ease(Linear.easeNone).onComplete(finish);
		}
		
		public function finish():Boolean 
		{
			agt.environment.eventDispatcher.dispatchEvent(new MVAgentEvent(agt, MVAgentEvent.SEEK_FINISHED));
			return true;
		}
		
		public function cancelOthers():Boolean 
		{
			return true;
		}
		
	}

}