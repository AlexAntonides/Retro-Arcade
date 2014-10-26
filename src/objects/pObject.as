package objects
{
	import flash.display.Sprite;
	import flash.events.Event;
	import background.TileClass;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import background.GameBackground;
	import screens.GameScreen;
	import flash.geom.Point;
	import assets.Assets;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class pObject extends MovieClip
	{
		public static const DESTROY_PLAYER:String = "destroy_player";
		public static const DESTROY_GHOST:String = "destroy_ghost";
		public static const SET_SCARED:String = "set_scared";
		public static const SET_NORMAL:String = "set_normal";
		
		internal var speed:Number = 2;
		internal var radius:Number = 50;
		
		private var currentTielX:int;
		private var currentTielY:int;
		private var previousDirectionX:int;
		private var previousDirectionY:int;
		
		private var flickerTime:int = 700;
		
		internal var _isNotSpawned:Boolean = true;
		private var updateIt:Boolean = true;
		private var updateIt2:Boolean = true;
		
		public static var playerDead:Boolean = false;
		public static var isScared:Boolean = false;
		public static var removeScared:Boolean = false;
		public static var stopDeath:Boolean = false;
		
		public static var killedUnit:int = 0;
		
		public var NextDirectionX:int;
		public var NextDirectionY:int;
		
		internal var scaredAsset1:Sprite = Assets.InstantiateSprite(Assets.ASSET_DEATH_1);
		internal var scaredAsset2:Sprite = Assets.InstantiateSprite(Assets.ASSET_DEATH_2);
		
		internal var eyesAssetUP:Sprite = Assets.InstantiateSprite(Assets.ASSET_EYES_UP);
		internal var eyesAssetDOWN:Sprite = Assets.InstantiateSprite(Assets.ASSET_EYES_DOWN);
		internal var eyesAssetLEFT:Sprite = Assets.InstantiateSprite(Assets.ASSET_EYES_LEFT);
		internal var eyesAssetRIGHT:Sprite = Assets.InstantiateSprite(Assets.ASSET_EYES_RIGHT);
		
		internal var scaredTimer:Timer;
		internal var score:Sprite;
		
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
			spooky4me();
			Alive();
		}
		
		internal function Alive():void
		{
			if ((this.x / TileClass.tileWidth) == 14 && (this.y / TileClass.tileHeight == 15))
			{
				removeScared = false;
			}
			else if ((this.x / TileClass.tileWidth) == 13 && (this.y / TileClass.tileHeight == 15))
			{
				removeScared = false;
			}
		}
		
		internal function CheckEyes():void
		{
			addChild(eyesAssetUP);
			addChild(eyesAssetDOWN);
			addChild(eyesAssetLEFT);
			addChild(eyesAssetRIGHT);
			
			hideAllAnimations(eyesAssetDOWN, eyesAssetLEFT, eyesAssetRIGHT);
		}
		
		internal function playAnimation(visibleAsset:Sprite, invisibleAsset1:Sprite, invisibleAsset2:Sprite, invisibleAsset3:Sprite):void
		{
			hideAllAnimations(invisibleAsset1, invisibleAsset2, invisibleAsset3);
			visibleAsset.visible = true;
		}
		
		internal function hideAllAnimations(Anim1:Sprite, Anim2:Sprite, Anim3:Sprite):void
		{
			Anim1.visible = false;
			Anim2.visible = false;
			Anim3.visible = false;
		}
		
		internal function CheckCollision():void
		{
			if (playerDead == false && isScared == false && stopDeath == false)
			{
				if (this.hitTestObject(GameScreen.player))
				{
					dispatchEvent(new Event(DESTROY_PLAYER, true));
				}
			}
		}
		
		internal function CollisionCheck():void
		{
		}
		
		internal function addScore(e:TimerEvent):void
		{
			GameScreen.player.visible = true;
			stage.frameRate = 30;
			//score.parent.removeChild(score);
		}
		
		internal function spooky4me():void
		{
			if (isScared && _isNotSpawned)
			{
				addChild(scaredAsset1);
				addChild(scaredAsset2);
				if (eyesAssetDOWN)
				{
					eyesAssetDOWN.visible = false;
				}
				if (eyesAssetLEFT)
				{
					eyesAssetLEFT.visible = false;
				}
				if (eyesAssetRIGHT)
				{
					eyesAssetRIGHT.visible = false;
				}
				if (eyesAssetUP)
				{
					eyesAssetUP.visible = false;
				}
				scaredTimer = new Timer(1000, 10);
				scaredTimer.addEventListener(TimerEvent.TIMER_COMPLETE, removeTheScared);
				scaredTimer.start();
				dispatchEvent(new Event(SET_SCARED));
				
				scaredAsset2.visible = false;
				
				_isNotSpawned = false;
			}
			if (isScared && _isNotSpawned == false && updateIt == true)
			{
				var timer:Timer = new Timer(6000, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
				timer.start();
				
				updateIt = false;
			}
			if (isScared && _isNotSpawned == false && updateIt == false)
			{
				hide();
			}
			CollisionCheck();
		}
		
		private function removeTheScared(e:TimerEvent):void
		{
			if (scaredAsset1 && contains(scaredAsset1))
			{
				scaredAsset1.parent.removeChild(scaredAsset1);
			}
			if (scaredAsset2 && contains(scaredAsset2))
			{
				scaredAsset2.parent.removeChild(scaredAsset2);
			}
			if (eyesAssetDOWN && contains(eyesAssetDOWN))
			{
				eyesAssetDOWN.parent.removeChild(eyesAssetUP);
			}
			if (eyesAssetDOWN && contains(eyesAssetDOWN))
			{
				eyesAssetDOWN.parent.removeChild(eyesAssetDOWN);
			}
			if (eyesAssetDOWN && contains(eyesAssetDOWN))
			{
				eyesAssetDOWN.parent.removeChild(eyesAssetLEFT);
			}
			if (eyesAssetDOWN && contains(eyesAssetDOWN))
			{
				eyesAssetDOWN.parent.removeChild(eyesAssetRIGHT);
			}
			
			isScared = false;
			playerDead = false;
			isScared = false;
			removeScared = false;
			stopDeath = false;
			GameBackground.sirenID = 1;
			
			_isNotSpawned = true;
			updateIt2 = true;
			
			dispatchEvent(new Event(SET_NORMAL, true));
		}
		
		internal function backToBase():void
		{
			if (this.x >= (14 * TileClass.tileWidth)) // RECHTS
			{
				Move("Left");
			}
			else if (this.x <= (14 * TileClass.tileWidth)) // LINKER
			{
				Move("Right");
			}
			if (this.y <= (17 * TileClass.tileHeight)) // BOVEN
			{
				Move("Down");
			}
			else if (this.y >= (17 * TileClass.tileHeight)) // ONDER
			{
				Move("Up");
			}
		}
		
		private function hide():void
		{
			var dif:Number = Math.sqrt(Math.pow(GameScreen.player.y - this.y, 2) + Math.pow(GameScreen.player.y - this.y, 2));
			if (dif <= radius)
			{
				FleeFromPlayer();
			}
			else if (dif >= radius)
			{
				RandomDirection();
			}
		}
		
		private function FleeFromPlayer():void
		{
			var playerLocation:Point = new Point(GameScreen.player.x, GameScreen.player.y);
			var differenceLocation:Point;
			
			var absolute:int;
			
			if (playerLocation != null)
			{
				differenceLocation = new Point(playerLocation.x - this.x, playerLocation.y - this.y);
			}
			
			if (differenceLocation.x != 0)
			{
				absolute = Math.abs(differenceLocation.x) / differenceLocation.x;
				if (absolute == Math.abs(absolute))
				{
					Move("Up");
				}
				else
				{
					Move("Down");
				}
			}
			else if (differenceLocation.y != 0)
			{
				absolute = Math.abs(differenceLocation.y) / differenceLocation.y;
				if (absolute == Math.abs(absolute))
				{
					Move("Left");
				}
				else
				{
					Move("Right");
				}
			}
		}
		
		private function onTrue(e:TimerEvent):void
		{
			if (scaredAsset1 != null && scaredAsset2 != null)
			{
				if (scaredAsset1.visible == true && scaredAsset2.visible == false)
				{
					scaredAsset2.visible = true;
					scaredAsset1.visible = false;
				}
				
				var timer:Timer = new Timer(flickerTime, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onFalse);
				timer.start();
			}
		}
		
		private function onFalse(e:TimerEvent):void
		{
			if (scaredAsset1 != null && scaredAsset2 != null)
			{
				if (scaredAsset1.visible == false && scaredAsset2.visible == true)
				{
					scaredAsset2.visible = false;
					scaredAsset1.visible = true;
				}
				
				var timer:Timer = new Timer(flickerTime, 1);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
				timer.start();
			}
		}
		
		internal function MoveAround():void
		{
			if (playerDead == false && isScared == false)
			{
				// Berekening = Sqrt((y2-y1)^2 + (x2-x1)^2)
				var dif:Number = Math.sqrt(Math.pow(GameScreen.player.y - this.y, 2) + Math.pow(GameScreen.player.y - this.y, 2));
				if (dif <= radius)
				{
					ChasePlayer();
				}
				else if (dif >= radius)
				{
					RandomDirection();
				}
			}
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
			else
			{ // Down
				Move("Down");
			}
		}
		
		internal function ChasePlayer():void
		{
			var playerLocation:Point = new Point(GameScreen.player.x, GameScreen.player.y);
			var differenceLocation:Point;
			
			var absolute:int;
			
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
			if (playerDead == false)
			{
				if (this.x / 16 % 1 == 0 && this.y / 16 % 1 == 0)
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
				else if (TileClass.tiles[currentTielY + previousDirectionY][currentTielX + previousDirectionX] != 0)
				{
					if (previousDirectionX == 1 && previousDirectionY == 0)
					{
						if (removeScared == true)
						{
							playAnimation(eyesAssetRIGHT, eyesAssetLEFT, eyesAssetDOWN, eyesAssetUP);
						}
					}
					else if (previousDirectionX == 0 && previousDirectionY == -1)
					{
						if (removeScared == true)
						{
							playAnimation(eyesAssetUP, eyesAssetRIGHT, eyesAssetDOWN, eyesAssetLEFT);
						}
					}
					else if (previousDirectionX == 0 && previousDirectionY == 1)
					{
						if (removeScared == true)
						{
							playAnimation(eyesAssetDOWN, eyesAssetRIGHT, eyesAssetLEFT, eyesAssetUP);
						}
					}
					else
					{
						if (removeScared == true)
						{
							playAnimation(eyesAssetLEFT, eyesAssetRIGHT, eyesAssetDOWN, eyesAssetUP);
						}
					}
					this.x += speed * previousDirectionX;
					this.y += speed * previousDirectionY;
				}
				if (TileClass.tiles[currentTielY + y][currentTielX + x] == 5 || TileClass.tiles[currentTielY + y][currentTielX + x] == 6)
				{
					this.x = 14 * TileClass.tileWidth; //14
					this.y = 17 * TileClass.tileHeight; //17
				}
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
		
		public function get isNotSpawned():Boolean
		{
			return _isNotSpawned;
		}
		
		public function set isNotSpawned(value:Boolean):void
		{
			_isNotSpawned = value;
		}
	
	}

}