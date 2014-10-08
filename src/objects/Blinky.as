package objects 
{
	import flash.events.Event;
	import background.TileClass;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Blinky extends pObject
	{
		private var asset:AssetBlinky = new AssetBlinky();
		private var timerOn:Boolean = false;
		private var up:Boolean = false;
		private var timer:Timer;
		private var counter:int = 1;
		private var maxMoves:int = 8;
		public function Blinky() 
		{
			addChild(asset);
			radius = 200;
			
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
			super.Move("Left");
			counter++;
			timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, checkUp);
			timer.start();
		}
		
		private function checkUp(e:TimerEvent):void 
		{
			up = true;
			timer = new Timer(300, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, goUp);
			timer.start();
		}
		
		private function goLeft(e:TimerEvent):void 
		{
			if (counter <= maxMoves)
			{
				if (up)
				{
					super.Move("Left");
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
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, goLeft);
				timer.start();
			}
		}
	}
}