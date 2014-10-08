package objects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import background.TileClass;
	import pickups.LargePoint;
	import screens.GameScreen;
	import pickups.SmallPoint;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Player extends MovieClip
	{
		public static const DESTROY_SMALL_POINT : String = "destroy_small_point";
		public static const DESTROY_LARGE_POINT : String = "destroy_large_point";
		
		private var leftAnim:MovieClip;
		private var rightAnim:MovieClip;
		private var upAnim:MovieClip;
		private var downAnim:MovieClip;
		private var idleAnim:MovieClip;
		
		private var speed:Number = 4;
		
		private var currentTielX:int;
		private var currentTielY:int;
		private var previousDirectionX:int;
		private var previousDirectionY:int;
		public var NextDirectionX: int;
		public var NextDirectionY: int;
		
		private var smallPoints:Array = [];
		private var bigPoints:Array = [];
		
		public function Player() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			leftAnim = new leftCharacter();
			rightAnim = new rightCharacter();
			upAnim = new upCharacter();
			downAnim = new downCharacter();
			idleAnim = new idleCharacter();
				
			smallPoints = TileClass.smallPoints; 
			bigPoints = TileClass.bigPoints;
			
			addChild(leftAnim);
			addChild(rightAnim);
			addChild(upAnim);
			addChild(downAnim);
			addChild(idleAnim);
			
			hideAllAnimations(rightAnim, upAnim, downAnim, idleAnim);
			
			currentTielX = this.x / TileClass.tileWidth;
			currentTielY = this.y / TileClass.tileHeight;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function CheckTile(x:int, y:int):void
		{
			if(this.x / 16 % 1 == 0 && this.y / 16 % 1 == 0)
			{
				currentTielX = this.x / 16;
				currentTielY = this.y / 16;
			}
			if (TileClass.tiles[currentTielY + y][currentTielX + x] != 0 && this.x / 16 % 1 == 0 && this.y / 16 % 1 == 0 && TileClass.tiles[currentTielY + y][currentTielX + x] != 2)
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
			if (TileClass.tiles[currentTielY + y][currentTielX + x] == 5)
			{
				this.x = 27 * TileClass.tileWidth; //28
				this.y = 17 * TileClass.tileHeight; //17
			}
			else if (TileClass.tiles[currentTielY + y][currentTielX + x] == 6)
			{
				this.x = 1 * TileClass.tileWidth; //0
				this.y = 17 * TileClass.tileHeight; //17
			}
		}
		
		private function update(e:Event):void
		{
			var lengthSP:int = smallPoints.length,
				lengthBP:int = bigPoints.length;
			
			for each (var smallP:SmallPoint in smallPoints)
			{
				if (this.hitTestObject(smallP)) 
				{
					smallPoints.splice(smallPoints.indexOf(smallP), 1);
					smallP.parent.removeChild(smallP);
					GameScreen.addScore(smallP.score);
				}
			}
			
			for each (var bigP:LargePoint in bigPoints)
			{
				if (this.hitTestObject(bigP)) 
				{
					bigPoints.splice(bigPoints.indexOf(bigP), 1);
					bigP.parent.removeChild(bigP);
					GameScreen.addScore(bigP.score);
				}
			}
			
			CheckTile(NextDirectionX, NextDirectionY);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) // Left
			{
				playAnimation(0);
				NextDirectionX = -1;
				NextDirectionY = 0;
			}
			
			if (e.keyCode == 39) // Right
			{
				playAnimation(1);
				NextDirectionX = 1;
				NextDirectionY = 0;
			}
			if (e.keyCode == 38) // Up
			{
				playAnimation(2);
				NextDirectionX = 0;
				NextDirectionY = -1;
			}
			if (e.keyCode == 40) // Down
			{
				playAnimation(3);
				NextDirectionX = 0;
				NextDirectionY = 1;
			}
		}
		
		private function playAnimation(animNr:int):void
		{
			switch(animNr)
			{
				case 0: // Left
				{
					hideAllAnimations(rightAnim, upAnim, downAnim, idleAnim);
					leftAnim.visible = true;
				}
					break;
				case 1: // Right
				{
					hideAllAnimations(leftAnim, upAnim, downAnim, idleAnim);
					rightAnim.visible = true;
				}
					break;
				case 2: // Up
				{
					hideAllAnimations(leftAnim, rightAnim, downAnim, idleAnim);
					upAnim.visible = true;	
				}
					break;
					
				case 3: // Down
				{
					hideAllAnimations(leftAnim, rightAnim, upAnim, idleAnim);
					downAnim.visible = true;
				}
					break;
			}
		}
		
		private function hideAllAnimations(Anim1:MovieClip, Anim2:MovieClip, Anim3:MovieClip, Anim4:MovieClip):void
		{
			Anim1.visible = false;
			Anim2.visible = false;
			Anim3.visible = false;
			Anim4.visible = false;
		}
		
	}

}