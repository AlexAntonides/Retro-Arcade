package pickups 
{
	import flash.utils.Timer;
	import background.GameBackground;
	import flash.events.TimerEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class LargePoint extends PickUp
	{
		public var score:int = 50;
		private var flickerTime : uint = 200;
		private var asset:bigPoint = new bigPoint();
		public function LargePoint() 
		{
			addChild(asset);
			
			var timer : Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
			timer.start();
		}
		
		private function onTrue(e:TimerEvent):void 
		{
			if (asset.visible == true && GameBackground.isReady)
			{
				asset.visible = false;
			}
			
			var timer : Timer = new Timer(flickerTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onFalse);
			timer.start();
		}
		
		private function onFalse(e:TimerEvent):void
		{
			if (asset.visible == false && GameBackground.isReady)
			{
				asset.visible = true;
			}
			
			var timer : Timer = new Timer(flickerTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
			timer.start();
		}
	}

}