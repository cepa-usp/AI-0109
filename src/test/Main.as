package test
{
	import cepa.ai.AI;
	import cepa.ai.AIInstance;
	import cepa.ai.AIObserver;
	import cepa.ai.IPlayInstance;
	import flash.display.Sprite;
	import flash.events.Event;

	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Main extends Sprite implements AIInstance, AIObserver 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/* INTERFACE cepa.ai.AIInstance */
		
		public function getData():Object 
		{
			return null;
		}
		
		public function readData(obj:Object) 
		{
			
		}
		
		public function createNewPlayInstance():IPlayInstance 
		{
			return null;
		}
		
		/* INTERFACE cepa.ai.AIObserver */
		
		public function onResetClick():void 
		{
			
		}
		
		public function onScormFetch():void 
		{
			
		}
		
		public function onScormSave():void 
		{
			
		}
		
		public function onStatsClick():void 
		{
			
		}
		
		public function onTutorialClick():void 
		{
			
		}
		
		public function onScormConnected():void 
		{
			
		}
		
		public function onScormConnectionError():void 
		{
			
		}
		
		/* INTERFACE cepa.ai.AIObserver */
		
		private function init(e:flash.events.Event=null):void 
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			trace("ok ok")
			var ai:AI = new AI(this);
			ai.initialize();
			ai.container.optionButtons.removeChild(ai.container.optionButtons.btStatistics)
			var qtBotoes:int = ai.container.optionButtons.numChildren-1			
			var mheight:int = -8;
			for (var i:int = 1; i <= qtBotoes; i++) {				
				mheight += ai.container.optionButtons.getChildAt(i).height + 6;
				trace(mheight, ai.container.optionButtons.getChildAt(i))
				ai.container.optionButtons.getChildAt(i).y = mheight;
			}
			mheight += 28
			ai.container.optionButtons.getChildAt(0).height = mheight;
			trace(qtBotoes, mheight)
		}

		
		
	}
	
}