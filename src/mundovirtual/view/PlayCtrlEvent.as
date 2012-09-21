package mundovirtual.view 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class PlayCtrlEvent extends Event 
	{
		private var _playCtrl:PlayCtrl;
		static public const PLAYSTATE_CHANGED:String = "playstateChanged";
		static public const VELOCITY_CHANGED:String = "velocityChanged";
		public function PlayCtrlEvent(playCtrl:PlayCtrl, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.playCtrl = playCtrl;
			
		} 
		
		public override function clone():Event 
		{ 
			return new PlayCtrlEvent(playCtrl, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PlayCtrlEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get playCtrl():PlayCtrl 
		{
			return _playCtrl;
		}
		
		public function set playCtrl(value:PlayCtrl):void 
		{
			_playCtrl = value;
		}
		
	}
	
}