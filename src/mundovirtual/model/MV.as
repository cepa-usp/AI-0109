package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Arthur
	 */
	public class MV 
	{
		
		private var _environment:MVEnvironment;
		private var _lab:MVEnvironment;
		
		public function MV() 
		{
			environment = new MVEnvironment(15, 13);			
			lab = new MVEnvironment(7, 7);
		}
		
		public function createAgents():void {
			
			for (var i:int = 0; i < 30; i++) 	{
				var a:MVAgent = new MVAgent().randomizeProperties();			
				var f:Point = findFreePosition()			
			
				if (i < 25) {
					environment.addAgent(a, f.x, f.y);
				} else {
					lab.addAgent(a, f.x, f.y);
				}
			}
			
		}
		
		public function findFreePosition():Point {			
			// not so much efficient... but pretty elegant
			var checkX:int = Math.floor(environment.width * Math.random());
			var checkY:int = Math.floor(environment.height * Math.random());
			if (!environment.checkPosition(checkX, checkY)) {
				return new Point(checkX, checkY);
			} else {
				return findFreePosition();
			}
		}
		
		public function start():void {
			for each (var a:Agent in environment.agents){
				a.run();
			}
		}
		
		public function get environment():MVEnvironment 
		{
			return _environment;
		}
		
		public function set environment(value:MVEnvironment):void 
		{
			_environment = value;
		}
		
		public function get lab():MVEnvironment 
		{
			return _lab;
		}
		
		public function set lab(value:MVEnvironment):void 
		{
			_lab = value;
		}
		
	}

}