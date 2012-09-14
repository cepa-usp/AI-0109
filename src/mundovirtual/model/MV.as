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
			lab = new MVEnvironment(5, 5);
		}
		
		public function createAgents():void {
			
			for (var i:int = 0; i < 30; i++) 	{
				var a:MVAgent = new MVAgent().randomizeProperties();			
				var f:Point;
			
				if (i < 28) {
					f = environment.findFreePosition();
					environment.addAgent(a, f.x, f.y);
				} else {
					f = lab.findFreePosition();
					lab.addAgent(a, f.x, f.y);
				}
			}
			
		}
		

		
		public function start():void {
			for each (var a:Agent in environment.agents){
				a.run();
			}
			for each (var aa:Agent in lab.agents){
				aa.run();
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