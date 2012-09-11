package mundovirtual.model 
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.reasoning.IReasoning;
	import cepa.multiagent.sensor.ISensor;
	import flash.geom.Point;

	
	/**
	 * This is the general agent for the 'Mundo Virtual' Learning Object
	 * @author Arthur
	 */
	public class MVAgent extends Agent 
	{
		public static const SHAPE_ROUND:int = 0;
		public static const SHAPE_TRI:int = 1;
		public static const SHAPE_TETRA:int = 2;
		public static const SHAPE_PENTA:int = 3;
		
		public static const COLOR_BLACK:int = 0;
		public static const COLOR_WHITE:int = 1;
		public static const COLOR_BLUE:int = 2;
		public static const COLOR_RED:int = 3;

		public static const SYMB_HEART:int = 0;
		public static const SYMB_SPADE:int = 1;
		public static const SYMB_GOLD:int = 2;
		public static const SYMB_CLUB:int = 3;		
		
		private var _shape:int = MVAgent.SHAPE_ROUND;
		private var _color:int = MVAgent.COLOR_BLACK;
		private var _symbol:int = MVAgent.SYMB_HEART;

		
		
		public function MVAgent() 
		{			

		}
		
		public function randomizeProperties():MVAgent {
			this._color = Math.floor(Math.random() * 3)
			this._symbol = Math.floor(Math.random() * 3)
			this._shape = Math.floor(Math.random() * 3)
			return this;
		}
		
		protected override function onEnvironmentChanged():void {
			createResources();
		}
		
		public function createResources():void {
			this.sensors = new Vector.<ISensor>();
			this.reasoning = new Vector.<IReasoning>();
			
			this.sensors.push(new Sensor_CheckPositions());
			this.reasoning.push(new Reasoning_Walk(this))			
		}
		

		
		public function commitTransformation():void {
			environment.eventDispatcher.dispatchEvent(new MVAgentEvent(this, MVAgentEvent.AGENT_TRANSFORMED))	
		}
		
		public function get shape():int 
		{
			return _shape;
		}
		
		public function set shape(value:int):void 
		{
			_shape = value;
		}
		
		public function get color():int 
		{
			return _color;
		}
		
		public function set color(value:int):void 
		{
			_color = value;
		}
		
		public function get symbol():int 
		{
			return _symbol;
		}
		
		public function set symbol(value:int):void 
		{
			_symbol = value;
		}
		
	}

}