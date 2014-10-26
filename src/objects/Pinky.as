package objects 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import background.TileClass;
	import screens.GameScreen;
	import uid.DataClass;
	import background.GameBackground;
	import assets.Assets;
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
		private var isDead:Boolean = false;
		private var maxMoves:int = 8;
		private var isEyes:Boolean = false;
		private var checkGhost:Boolean = false;
		
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
		
		private function setScared(e:Event):void 
		{
			checkGhost = false;
		}
		
		override internal function myUpdate(e:Event):void 
		{
			super.CheckTile(NextDirectionX, NextDirectionY);
			if (pObject.playerDead == false)
			{
				MoveToLocation();
			}
			super.CheckCollision();
			CheckRandom();
			updateScared();
			if (isEyes == false)
			{
				super.spooky4me();
			}
			else if (isEyes == true)
			{
				backToBase();
			}
			super.Alive();
			addEventListener(pObject.DESTROY_GHOST, destroyGhost);
			addEventListener(pObject.SET_SCARED, setScared);
			addEventListener(pObject.SET_NORMAL, setNormal);
		}
		
		private function setNormal(e:Event):void 
		{
			checkGhost = false;
			isEyes = false;
		}
		
		override internal function backToBase():void
		{
			if (this.x >=  (14 * TileClass.tileWidth)) // RECHTS
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
			
			if (super.isNotSpawned)
			{
				isEyes = false;
			}
		}
		
		private function destroyGhost(e:Event):void 
		{
			if (isDead == false)
			{
				if (this.hitTestObject(GameScreen.player))
				{
					if (scaredAsset1 && contains(scaredAsset1)){scaredAsset1.parent.removeChild(scaredAsset1);}
					if (scaredAsset2 && contains(scaredAsset2)){scaredAsset2.parent.removeChild(scaredAsset2);}
					isDead = true;
					super.CheckEyes();
				}
			}
		}
		
		
		override internal function CollisionCheck():void
		{
			if (playerDead == false && isScared == true && checkGhost == false)
			{
				if (this.hitTestObject(GameScreen.player))
				{
					GameScreen.playerLocation.x = GameScreen.player.x;
					GameScreen.playerLocation.y = GameScreen.player.y;
					
					GameBackground.sirenID = 3;
					GameScreen.player.visible = false;
					asset.visible = false;
					var timer:Timer = new Timer(1000, 1);
					
					checkGhost = true;
					
					stopDeath = true;
					pObject.killedUnit++;
					dispatchEvent(new Event(DESTROY_GHOST, true));
					Assets.PlaySound(Assets.SOUND_EAT_GHOST);
					removeScared = true;
					stage.frameRate = 0;
					
					if (killedUnit == 1)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_GHOST_200);
						DataClass.score += 200;
					}
					else if (killedUnit == 2)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_GHOST_400);
						DataClass.score += 400;
					}
					else if (killedUnit == 3)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_GHOST_800);
						DataClass.score += 800;
					}
					else if (killedUnit == 4)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_GHOST_1600);
						DataClass.score += 1600;
					}
					else if (killedUnit >= 5)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_GHOST_3200);
						DataClass.score += 3200;
					}
					
					GameScreen.addMyChild(GameScreen.playerLocation.x, GameScreen.playerLocation.y, score, stage);
					
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, addScore);
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, visibletrue);
					timer.start();
				}
			}
		}
		
		private function visibletrue(e:TimerEvent):void 
		{
			asset.visible = true;
		}
		
		private function updateScared():void 
		{
			if (pObject.isScared)
			{
				counter = maxMoves;
			}
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