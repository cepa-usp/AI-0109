package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.environment.Environment;
	import cepa.multiagent.environment.EnvrPosition;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import util.matrix;
		
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
		
		public override function checkPosition(agt:Agent, x:int, y:int):Boolean {
			if (x < 0 || x>=this.width) return true;
			if (y <0 || y >= this.height) return true;			
			var p:EnvrPosition = pos[x][y];
			if (p.agentHere != null) {
				if(agt!=null){
					collideAgents(MVAgent(agt), MVAgent(p.agentHere));
				}
				return true;
			} 
			return false;
		}		
		
		public function addAgent(ag:MVAgent, iniX:int, iniY:int):void {
			registerAgent(ag, iniX, iniY)
			
		}
		
		public function collideAgents(ag1:MVAgent, ag2:MVAgent):void {
			var p_colors:Point = findMatrixValues(ag1.color, ag2.color);
			var p_symbol:Point = findMatrixValues(ag1.symbol, ag2.symbol);
			ag1.color = p_colors.x;
			ag2.color = p_colors.y;
			ag1.symbol = p_symbol.x;
			ag2.symbol = p_symbol.y;
			ag1.commitTransformation();
			ag2.commitTransformation();
			
			var ev:MVAgentEvent = new MVAgentEvent(ag1, MVAgentEvent.AGENT_COLLIDED);
			ev.collidedWith = ag2;
			eventDispatcher.dispatchEvent(ev);
		}
		
		public function findMatrixValues(val1:int, val2:int):Point {
			var c:matrix = new matrix(2, 2, 1, -1, -1, 1)
			var c2:matrix = new matrix(1, 2, val1, val2);
			var c3:matrix = c.mulMatrix(c2);
			var p:Point = new Point(c3.getElement(0, 0), c3.getElement(0, 1))
			p.x = wrap(p.x, 3, 0);
			p.y = wrap(p.y, 3, 0);
			return p;
		}
		
		public function wrap(x:Number, d:Number, x0:Number):Number {
			return x - d * Math.floor((x - x0) / d);
		}
		
		public function findFreePosition():Point {			
			// not so much efficient... but pretty elegant
			var checkX:int = Math.floor(width * Math.random());
			var checkY:int = Math.floor(height * Math.random());
			if (!this.checkPosition(null, checkX, checkY)) {
				return new Point(checkX, checkY);
			} else {
				return findFreePosition();
			}
		}			
		

		
	}

}