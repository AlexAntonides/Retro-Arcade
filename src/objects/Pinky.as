package objects 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Pinky extends pObject
	{
		private var asset:AssetPinky = new AssetPinky();
		private var timerOn:Boolean = false;
		private var right:Boolean = false;
		private var timer:Timer;
		private var counter:int = 1;
		private var maxMoves:int = 8;
		
		public function Pinky() 
		{
			addChild(asset);
			radius = 100;
		}	
		
		/* 
		 * Deze class is -NIET- OOP Gemaakt.
		 * Ik gebruik veel timer functies, zodat het lijkt op de originele pac-man.
		 * Als hij op de locatie komt, gaat de class "Random-Movement" af.
		 */
		
		override internal function myUpdate(e:Event):void 
		{
			super.CheckTile(NextDirectionX, NextDirectionY);
			MoveToLocation();
			super.CheckCollision();
			CheckRandom();
		}
		
		private function CheckRandom():void 
		{
			if (counter >= maxMoves)
			{
				super.MoveAround();
			}
		}
		
		private function MoveToLocation():void 
		{
			if (timerOn == false)
			{
				timer = new Timer(250, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, move);
				timer.start();	
				timerOn = true;
			}
		}
		
		private function move(e:TimerEvent):void 
		{
			super.Move("Up");
			counter++;
			timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, checkRight);
			timer.start();
		}
		
		private function checkRight(e:TimerEvent):void 
		{
			right = true;
			timer = new Timer(300, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, goRight);
			timer.start();
		}
		
		private function goRight(e:TimerEvent):void 
		{
			if (counter <= maxMoves)
			{
				if (right)
				{
					super.Move("Right");
					counter++;
					
					timer = new Timer(250, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, goUp);
					timer.start();
				}
			}
		}
		
		private function goUp(e:TimerEvent):void 
		{
			if (counter <= maxMoves)
			{
				super.Move("Up");
				
				timer = new Timer(250, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, goRight);
				timer.start();
			}
		}
		
	}

}