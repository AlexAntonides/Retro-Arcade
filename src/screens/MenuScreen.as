package screens 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import assets.Assets;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class MenuScreen extends Screen 
	{
		static public const START_GAME:String = "startGame";
		private var anim:MovieClip;
		private var _root:Root = new Root();
			
		public function MenuScreen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			anim = Assets.InstantiateMovieclip(Assets.ANIM_START);
			addChild(anim);
			
			anim.addEventListener(Event.ENTER_FRAME, checkFrames);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 27)
			{
				Assets.PlaySound(Assets.SOUND_CHOMP);
				
				var timer:Timer = new Timer(400, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, goToGame);
				timer.start();
			}
			else if (e.keyCode == 32)
			{
				if (anim.currentFrame == anim.totalFrames)
				{
					Assets.PlaySound(Assets.SOUND_CHOMP);
					
					var tTimer:Timer = new Timer(400, 1);
					tTimer.addEventListener(TimerEvent.TIMER_COMPLETE, goToGame);
					tTimer.start();
				}
			}
		}
		
		private function goToGame(e:TimerEvent):void 
		{
			removeAllEvents();
			removeScreen(getScreen(), 1);
		}
		
		private function removeAllEvents():void
		{
			anim.stop();
			anim.removeEventListener(Event.ENTER_FRAME, checkFrames);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function checkFrames(e:Event):void 
		{
			if (anim.currentFrame == anim.totalFrames)
			{
				anim.stop();
			}
		}
		
	}

}