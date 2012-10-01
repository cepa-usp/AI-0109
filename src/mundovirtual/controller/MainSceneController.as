package mundovirtual.controller 
{
	import mundovirtual.model.MV;
	import mundovirtual.view.MainScene;
	import mundovirtual.view.PlayCtrlEvent;
	/**
	 * ...
	 * @author Arthur
	 */
	public class MainSceneController 
	{
		private var mv:MV;
		private var mainScene:MainScene;
		
		public function MainSceneController(mainScene:MainScene, mv:MV) 
		{
			this.mainScene = mainScene;
			this.mv = mv;
			mainScene.playControl.addEventListener(PlayCtrlEvent.PLAYSTATE_CHANGED, onPlaystateChanged);
			mainScene.playControl.addEventListener(PlayCtrlEvent.VELOCITY_CHANGED, onVelocityChanged);
		}
		
		private function onPlaystateChanged(e:PlayCtrlEvent):void 
		{
			if (e.playCtrl.playState == 0) {
				mv.pause();
			} else if (e.playCtrl.playState == 1){
				mv.play();
			}
		}
		
		private function onVelocityChanged(e:PlayCtrlEvent):void 
		{
			MV.velocity = e.playCtrl.velocity;
		}
		
	}

}