package mundovirtual.view 
{
	import com.eclecticdesignstudio.motion.Actuate;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Arthur
	 */
	public class PlayCtrl extends PlayControls 
	{
		
		private var _playState:int = 1;
		private var _playVel:int = 2;
		private var velModifiers:Array = [0.25, 0.5, 1, 2, 2]
		
		
		public function PlayCtrl() 
		{
			makePlayButton(this.btPlayPause)
			btPlayPause.gotoAndStop(1);
			btFaster.gotoAndStop(1);
			btSlower.gotoAndStop(1);
			setBall();
			
			makeVelButton(this.btFaster)
			makeVelButton(this.btSlower)
			btFaster.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
				if (playVel < 4) playVel++;
			});
			btSlower.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
				if (playVel > 0) playVel--;
			});			
		}
		
		private function setBall():void {
			bolinha.y = linhaBase.y;
			var xx:Number = (linhaBase.width / 5) * playVel;
			xx += linhaBase.x + 10;
			Actuate.tween(bolinha, 0.5, { x:xx } );
		}
		

		private function makePlayButton(bt:MovieClip):void 
		{
			
			bt.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				if (playState == 0) {
					playState = 1;
					bt.gotoAndStop(2)
				} else {
					playState = 0;
					bt.gotoAndStop(4)
				}
			});
			bt.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent):void {
				bt.gotoAndStop((playState==0?4:2));
			});
			bt.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent):void {
				bt.gotoAndStop((playState==0?3:1));
			});			
		}
		
		private function makeVelButton(bt:MovieClip):void 
		{
			bt.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent):void {
				bt.gotoAndStop(2);
			});
			bt.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent):void {
				bt.gotoAndStop(1);
			});			
			
		}
		
		public function get velocity():Number {
			return velModifiers[playVel];
		}
				
		public function get playState():int 
		{
			return _playState;
		}
		
		public function set playState(value:int):void 
		{
			_playState = value;
			dispatchEvent(new PlayCtrlEvent(this, PlayCtrlEvent.PLAYSTATE_CHANGED));
		}
		
		public function get playVel():int 
		{
			return _playVel;
		}
		
		public function set playVel(value:int):void 
		{
			_playVel = value;
			setBall();
			dispatchEvent(new PlayCtrlEvent(this, PlayCtrlEvent.VELOCITY_CHANGED));
			
		}
		
	}
	

}