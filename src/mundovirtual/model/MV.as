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
		private var _lastAmnt:int = 0;
		private static var _velocity:Number = 1;
		private var _environment:MVEnvironment;
		private var _lab:MVLab;
		private var _paused:Boolean = false;
		
		public function MV() 
		{
			environment = new MVEnvironment(15, 13);			
			lab = new MVLab(5, 5);
		}

		public function showLab(val:Boolean):void {
			lab.visible = val;
		}
		
		public function clear():void {
			for (var i:int = environment.agents.length - 1; i >= 0; i-- ) {
				var a:Agent = environment.agents[i];
				environment.removeAgent(a);
			}
			for (var iii:int = lab.agents.length - 1; iii >= 0; iii-- ) {
				var aaa:Agent = lab.agents[iii];
				lab.removeAgent(aaa);
			}			
		}
		
		
		public function createAgents(amnt:int):void {
			lastAmnt = amnt;
			for (var i:int = 0; i < amnt; i++) 	{
				var a:MVAgent = new MVAgent().randomizeProperties();			
				var f:Point;
			

					f = environment.findFreePosition();
					environment.addAgent(a, f.x, f.y);
				
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
			paused = true;
			for each (var a:Agent in environment.agents){
				for each(var r:IReasoning in a.reasoning) {
					r.cancel();
				}
			}
			for each (var aa:Agent in lab.agents){
				for each(var rr:IReasoning in aa.reasoning) {
					rr.cancel();
				}
			}
		}
		
		public function play():void 
		{
			paused = false;
			for each (var a:Agent in environment.agents) MVAgent(a).createResources();
			for each (var aaa:Agent in lab.agents) MVAgent(aaa).createResources();
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
		
		public function get lab():MVLab 
		{
			return _lab;
		}
		
		public function set lab(value:MVLab):void 
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
		
		public function get paused():Boolean 
		{
			return _paused;
		}
		
		public function set paused(value:Boolean):void 
		{
			_paused = value;
		}
		
		public function get lastAmnt():int 
		{
			return _lastAmnt;
		}
		
		public function set lastAmnt(value:int):void 
		{
			_lastAmnt = value;
		}
		
	}

}