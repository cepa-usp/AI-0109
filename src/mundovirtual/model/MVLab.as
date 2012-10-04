package mundovirtual.model 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class MVLab extends MVEnvironment 
	{
		private var _visible:Boolean = false;
		public function MVLab(w:int, h:int) 
		{
			super(w, h);
			
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			_visible = value;
			eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}