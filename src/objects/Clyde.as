package objects 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Clyde extends pObject
	{
		private var asset:AssetClyde = new AssetClyde();
		private var timerOn:Boolean = false;
		private var up:Boolean = false;
		private var timer:Timer;
		private var counter:int = 1;
		private var maxMoves:int = 8;
		private var maxUp:int = 25;
		private var down:Boolean = false;
		
		public function Clyde() 
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
			WaitTillMove();
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
		
		private function WaitTillMove():void 
		{
			if (timerOn == false)
			{
				timerOn = true;
				timer = new Timer(400, maxUp);
				timer.addEventListener(TimerEvent.TIMER, upDown);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, MoveToLocation);
				timer.start();
			}
		}
		
		private function upDown(e:TimerEvent):void 
		{
			if (down == false)
			{
				super.Move("Up");
				down = true;
			}
			else if (down == true)
			{
				super.Move("Down");
				down = false;
			}
		}
		
		private function MoveToLocation(e:TimerEvent):void 
		{
			super.Move("Left");
			
			timer = new Timer(400, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, move);
			timer.start();	
		}
		
		private function move(e:TimerEvent):void 
		{
			super.Move("Up");
			counter++;
			timer = new Timer(300, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, checkUp);
			timer.start();
		}
		
		private function checkUp(e:TimerEvent):void 
		{
			up = true;
			timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, goRight);
			timer.start();
		}
		
		private function goRight(e:TimerEvent):void 
		{
			if (counter <= maxMoves)
			{
				if (up)
				{
					super.Move("Right");
					counter++;
					timer = new Timer(400, 1);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, goDown);
					timer.start();
				}
			}
		}
		
		private function goDown(e:TimerEvent):void 
		{
			if (counter <= maxMoves)
			{
				super.Move("Down");
				
				timer = new Timer(400, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, goRight);
				timer.start();
			}
		}
	}

}