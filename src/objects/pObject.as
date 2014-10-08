package objects 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import background.TileClass;
	import flash.display.MovieClip;
	import screens.GameScreen;
	import flash.geom.Point;
	
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class pObject extends MovieClip
	{
		public static const DESTROY_PLAYER : String = "destroy_player";
		internal var speed:Number = 2;
		internal var radius:Number = 50;
		
		private var currentTielX:int;
		private var currentTielY:int;
		private var previousDirectionX:int;
		private var previousDirectionY:int;
		
		public var NextDirectionX: int;
		public var NextDirectionY: int;
		
		private var randomDirection:int;
		
		public function pObject() 
		{
			currentTielX = this.x / TileClass.tileWidth;
			currentTielY = this.y / TileClass.tileHeight;
			addEventListener(Event.ENTER_FRAME, myUpdate);
		}
		
		internal function myUpdate(e:Event):void 
		{
			CheckTile(NextDirectionX, NextDirectionY);
			MoveAround();
			CheckCollision();
		}
		
		internal function CheckCollision():void 
		{
			if (this.hitTestObject(GameScreen.player))
			{
				dispatchEvent(new Event(DESTROY_PLAYER, true));
			}
		}
		
		internal function MoveAround():void 
		{
			// Berekening = Sqrt((y2-y1)^2 + (x2-x1)^2)
			var dif:Number = Math.sqrt(Math.pow(GameScreen.player.y - this.y, 2) + Math.pow(GameScreen.player.y - this.y, 2));
			if (dif <= radius)
			{
				ChasePlayer();
				//Chase();
			}
			else if (dif >= radius)
			{
				RandomDirection();
			}
		} 
		
		internal function Chase():void 
		{
			var openList:Point;
			var closedList:Point = new Point(this.x, this.y);
			
		}
		
		
		internal function RandomDirection():void 
		{
			randomDirection = Math.floor(Math.random() * 4);
			
			if (randomDirection == 1) // Left
			{
				Move("Left");
			}
			else if (randomDirection == 2) // Right
			{
				Move("Right");
			}
			else if (randomDirection == 3) // Up
			{
				Move("Up");
			}
			else { // Down
				Move("Down");
			}
		}
		
		internal function ChasePlayer():void 
		{
			var playerLocation:Point = new Point(GameScreen.player.x, GameScreen.player.y);
			var	differenceLocation : Point;
			
			var absolute: int;
			
			if (playerLocation != null)
			{
				differenceLocation = new Point(playerLocation.x - this.x, playerLocation.y - this.y);
			}
			
			if (differenceLocation.x != 0)
			{
				absolute = Math.abs(differenceLocation.x) / differenceLocation.x;
				if (absolute == Math.abs(absolute)) 
				{
					Move("Right");
				}
				else 
				{
					Move("Left");
				}
			}
			else if (differenceLocation.y != 0)
			{
				absolute = Math.abs(differenceLocation.y) / differenceLocation.y;
				if (absolute == Math.abs(absolute))
				{
					Move("Down");
				}
				else
				{
					Move("Up");
				}
			}
		}
		
		internal function CheckTile(x:int, y:int):void
		{
			if(this.x / 16 % 1 == 0 && this.y / 16 % 1 == 0)
			{
				currentTielX = this.x / 16;
				currentTielY = this.y / 16;
			}
			if (TileClass.tiles[currentTielY + y][currentTielX + x] != 0 && this.x / 16 % 1 == 0 && this.y / 16 % 1 == 0 && TileClass.tiles[currentTielY + y][currentTielX + x] != 7)
			{
				this.x += speed * x;
				this.y += speed * y;
				
				previousDirectionX = x;
				previousDirectionY = y;
			}
			else if (TileClass.tiles[currentTielY + previousDirectionY][ currentTielX + previousDirectionX] != 0)
			{
				this.x += speed * previousDirectionX;
				this.y += speed * previousDirectionY;
			}
		}
		
		internal function Move(location:String):void
		{
			if (location == "left" || location == "Left")
			{
				NextDirectionX = -1;
				NextDirectionY = 0;
			}
			else if (location == "right" || location == "Right")
			{
				NextDirectionX = 1;
				NextDirectionY = 0;
			}
			else if (location == "up" || location == "Up")
			{
				NextDirectionX = 0;
				NextDirectionY = -1;
			}
			else if (location == "down" || location == "Down")
			{
				NextDirectionX = 0;
				NextDirectionY = 1;
			}
		}
	}

}