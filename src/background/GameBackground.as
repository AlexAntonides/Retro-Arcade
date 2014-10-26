package background 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import assets.Assets;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class GameBackground extends Sprite 
	{
		public static var isReady:Boolean = false;
		public static var sirenID:int = 1;
		private var bg:MovieClip;
		private var sc:SoundChannel = new SoundChannel();
		private var sSC:SoundChannel = new SoundChannel();
		private var soundSirenTimer:int = 420; // 420
		private var soundScaredSirenTimer:int = 450; // 450
		private var soundEyesSirenTimer:int = 300; // 300
		public function GameBackground() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			bg = new Background();
			addChild(bg);
			
			stop();
			
			stage.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void 
		{
			if (sc.position == 0 || sc.position >= soundSirenTimer && isReady && sirenID == 1)
			{
				sc = Assets.PlaySound(Assets.SOUND_SIREN);
			}
			else if (sc.position == 0 || sc.position >= soundScaredSirenTimer && isReady && sirenID == 2)
			{
				sc = Assets.PlaySound(Assets.SOUND_SCAREDSIREN);
			}
			else if (sc.position == 0 || sc.position >= soundEyesSirenTimer && isReady && sirenID == 3)
			{
				sc = Assets.PlaySound(Assets.SOUND_EYESSIREN);
			}
			if (sSC.position == 0 && isReady == false)
			{
				sSC = Assets.PlaySound(Assets.SOUND_BEGINNING);
				sSC.addEventListener(Event.SOUND_COMPLETE, change);
			}
		}
		
		private function change(e:Event):void 
		{
			isReady = true;
		}
		
		public function start():void
		{
			bg.play();
		}
		
		public function stop():void
		{
			bg.gotoAndStop(1);
		}
	}

}