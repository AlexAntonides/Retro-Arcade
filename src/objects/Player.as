package objects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import background.TileClass;
	import flash.events.TimerEvent;
	import background.GameBackground;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import assets.Assets;
	import pickups.LargePoint;
	import uid.InterfaceDesign;
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
		public static const RESTORE_PLAYER : String = "restore_player";
		public static const SET_SCARED : String = "set_scared";
		
		private var canIPlayAnimation:Boolean = true;
		
		private var leftAnim:MovieClip;
		private var rightAnim:MovieClip;
		private var upAnim:MovieClip;
		private var downAnim:MovieClip;
		private var idleAnim:MovieClip;
		private var deathAnim:MovieClip;
		
		private var speed:Number = 4;
		
		private var currentTielX:int;
		private var currentTielY:int;
		private var previousDirectionX:int;
		private var previousDirectionY:int;
		public var NextDirectionX: int;
		public var NextDirectionY: int;
		
		private var smallPoints:Array = [];
		private var bigPoints:Array = [];
		
		private var sc:SoundChannel = new SoundChannel();
		private var soundChompTimer:int = 200;
		
		private var sSC:SoundChannel = new SoundChannel();
		
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
			deathAnim = new AssetDeathAnim();
				
			smallPoints = TileClass.smallPoints; 
			bigPoints = TileClass.bigPoints;
			
			addChild(leftAnim);
			addChild(rightAnim);
			addChild(upAnim);
			addChild(downAnim);
			addChild(deathAnim);
			addChild(idleAnim);
			
			deathAnim.gotoAndStop(0);
			deathAnim.visible = false;
			hideAllAnimations(rightAnim, upAnim, downAnim, leftAnim);
			
			currentTielX = this.x / TileClass.tileWidth;
			currentTielY = this.y / TileClass.tileHeight;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(InterfaceDesign.PLAY_DEATH_ANIMATION, playDeath);
			stage.addEventListener(InterfaceDesign.GAME_OVER, removeSelf);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function playDeath(e:Event):void 
		{
			hideAllAnimations(rightAnim, upAnim, downAnim, leftAnim, idleAnim);
			sSC = Assets.PlaySound(Assets.SOUND_DEATH);
			canIPlayAnimation = false;
			pObject.playerDead = true;
			pObject.stopDeath = true;
			deathAnim.visible = true;
			deathAnim.gotoAndPlay(0);
			deathAnim.addFrameScript(deathAnim.totalFrames - 1, function():void
			{
				sSC.addEventListener(Event.SOUND_COMPLETE, respawn); 
				deathAnim.stop();
				deathAnim.visible = false;
			});
		}
		
		private function respawn(e:Event):void 
		{
			canIPlayAnimation = true;
			leftAnim.visible = true;
			GameScreen.setPlayerLocation();
			pObject.stopDeath = false;
		}
		
		private function removeSelf(e:Event):void 
		{
			deathAnim.addFrameScript(deathAnim.totalFrames -1, function():void
			{
				removeEventListener(Event.ENTER_FRAME, update);
				deathAnim.stop();
				deathAnim.visible = false;
				this.visible = false;
				pObject.playerDead = true;
			});
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
				if (canIPlayAnimation)
				{
					if (previousDirectionX == 1 && previousDirectionY == 0)
					{
						playAnimation(1);
					}
					else if (previousDirectionX == 0 && previousDirectionY == -1)
					{
						playAnimation(2);
					}
					else if (previousDirectionX == 0 && previousDirectionY == 1)
					{
						playAnimation(3);
					}
					else 
					{
						playAnimation(0);
					}
					this.x += speed * previousDirectionX;
					this.y += speed * previousDirectionY;
				}
			}
			if (TileClass.tiles[currentTielY + y][currentTielX + x] == 5)
			{
				this.x = 27 * TileClass.tileWidth; //28
				this.y = 17 * TileClass.tileHeight; //17
			}
			else if (TileClass.tiles[currentTielY + y][currentTielX + x] == 6)
			{
				this.x = 1 * TileClass.tileWidth; //1
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
					GameScreen.eatenDots++;
					speed = 3;
					if (sc.position == 0 || sc.position >= soundChompTimer)
					{
						sc = Assets.PlaySound(Assets.SOUND_CHOMP);
					}
				}
			}
			
			for each (var bigP:LargePoint in bigPoints)
			{
				if (this.hitTestObject(bigP)) 
				{
					bigPoints.splice(bigPoints.indexOf(bigP), 1);
					bigP.parent.removeChild(bigP);
					GameScreen.addScore(bigP.score);
					pObject.isScared = true;
					GameScreen.eatenDots++;
					GameBackground.sirenID = 2;
					dispatchEvent(new Event(SET_SCARED, true));
					if (sc.position == 0 || sc.position >= soundChompTimer)
					{
						sc = Assets.PlaySound(Assets.SOUND_CHOMP);
					}
				}
			}
			
			CheckTile(NextDirectionX, NextDirectionY);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) // Left
			{
				NextDirectionX = -1;
				NextDirectionY = 0;
			}
			
			if (e.keyCode == 39) // Right
			{
				NextDirectionX = 1;
				NextDirectionY = 0;
			}
			if (e.keyCode == 38) // Up
			{
				NextDirectionX = 0;
				NextDirectionY = -1;
			}
			if (e.keyCode == 40) // Down
			{
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
		
		private function hideAllAnimations(...anim):void
		{
			for each (var animation:MovieClip in anim)
			{
				animation.visible = false;
			}
		}
		
	}

}