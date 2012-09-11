package mundovirtual.model 
{
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.environment.Environment;
		
	/**
	 * ...
	 * @author Arthur
	 */
	public class MVEnvironment extends Environment 
	{
		
		// Min and Max agents on this environment
		private var nMinAgents:int = 20;
		private var nMaxAgents:int = 30;
		
		
		
		public function MVEnvironment(w:int, h:int) 
		{
				this.width = w;
				this.height = h;
		}
		
		public function addAgent(ag:MVAgent, iniX:int, iniY:int):void {
			registerAgent(ag, iniX, iniY)
			
		}
		
		public function collideAgents(ag1:MVAgent, ag2:MVAgent):void {
			
		}
		

		
	}

}