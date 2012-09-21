package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.reasoning.IReasoning;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Arthur
	 */
	public class MV 
	{
		
		private static var _velocity:Number = 1;
		private var _environment:MVEnvironment;
		private var _lab:MVEnvironment;
		
		public function MV() 
		{
			environment = new MVEnvironment(15, 13);			
			lab = new MVEnvironment(5, 5);
		}
		
		public function createAgents():void {
			
			for (var i:int = 0; i < 20; i++) 	{
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
		
		public function pause():void 
		{
			for each (var a:Agent in environment.agents){
				for each(var r:IReasoning in a.reasoning) {
					r.cancel();
				}
			}
			for each (var a:Agent in lab.agents){
				for each(var r:IReasoning in a.reasoning) {
					r.cancel();
				}
			}
		}
		
		public function play():void 
		{
			for each (var a:Agent in environment.agents) MVAgent(a).createResources();
			for each (var a:Agent in lab.agents) MVAgent(a).createResources();
			start();
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
		
		static public function get velocity():Number 
		{
			return 1/_velocity;
		}
		
		static public function set velocity(value:Number):void 
		{
			_velocity = value;
		}
		
	}

}