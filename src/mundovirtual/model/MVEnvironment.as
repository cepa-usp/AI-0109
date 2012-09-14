package mundovirtual.model 
{
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.environment.Environment;
	import flash.geom.Point;
		
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
		
		public function findFreePosition():Point {			
			// not so much efficient... but pretty elegant
			var checkX:int = Math.floor(width * Math.random());
			var checkY:int = Math.floor(height * Math.random());
			if (!this.checkPosition(checkX, checkY)) {
				return new Point(checkX, checkY);
			} else {
				return findFreePosition();
			}
		}			
		

		
	}

}