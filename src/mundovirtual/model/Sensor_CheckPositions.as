package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.sensor.ISensor;
	/**
	 * ...
	 * @author Arthur
	 */
	public class Sensor_CheckPositions implements ISensor
	{
		
		public function Sensor_CheckPositions() 
		{
			
		}
		
		/* INTERFACE cepa.multiagent.sensor.ISensor */
		
		public function receive(agt:Agent):void 
		{
			agt.vars.positions = [];
		}
		
	}

}