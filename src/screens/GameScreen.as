package screens
{
	import background.GameBackground;
	import background.TileClass;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import objects.Blinky;
	import objects.Clyde;
	import objects.Inky;
	import objects.Pinky;
	import objects.Player;
	import assets.Assets;
	import objects.pObject;
	import pickups.Fruit;
	import uid.InterfaceDesign;
	import uid.DataClass;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class GameScreen extends Screen
	{
		static public const TURN_GHOST:String = "turn_ghost";
		static public const END_GAME:String = "end_game";
		static public const LEVEL_UP:String = "level_up";
		
		private var textSize1:int = 16;
		private var textSize2:int = 17;
		
		private var tiles:TileClass = new TileClass();
		public static var player:Player = new Player();
		private var pBackground:GameBackground = new GameBackground();
		private var interfaceDesign:InterfaceDesign = new InterfaceDesign();
		
		private var blinky:Blinky = new Blinky();
		private var pinky:Pinky = new Pinky();
		private var inky:Inky = new Inky();
		private var clyde:Clyde = new Clyde();
		
		private var fruits:Fruit = new Fruit();
		
		public static var playerLocation:Point;
		public static var eatenDots:int = 0;
		
		public static var level:uint = 1;
		
		public static var levelCheck:Boolean = false;
		
		private var font:Font = Assets.InstantiateFont(Assets.FONT_SCORE);
		
		private var textPlayerOne:TextField = new TextField();
		private var textReady:TextField = new TextField();
		
		private var formatPlayerOne:TextFormat = new TextFormat();
		private var formatReady:TextFormat = new TextFormat();
		
		public function GameScreen()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			pBackground.x = 10;
			player.x = 14 * TileClass.tileWidth; //14
			blinky.x = 14 * TileClass.tileWidth; //14
			pinky.x = 13 * TileClass.tileWidth; //14
			inky.x = 11 * TileClass.tileWidth; //14
			clyde.x = 16 * TileClass.tileWidth; //14
			fruits.x = 14 * TileClass.tileWidth;
			
			pBackground.y = 60;
			player.y = 26 * TileClass.tileHeight; //26
			blinky.y = 14 * TileClass.tileHeight; //14
			pinky.y = 17 * TileClass.tileHeight; //14
			inky.y = 17 * TileClass.tileHeight; //14
			clyde.y = 17 * TileClass.tileHeight; //14
			fruits.y = 20 * TileClass.tileHeight;
			
			playerLocation = new Point(player.x, player.y);
			
			formatPlayerOne.font = font.fontName;
			formatReady.font = font.fontName;
			
			formatPlayerOne.size = textSize1;
			formatReady.size = textSize2;
			
			textPlayerOne.defaultTextFormat = formatPlayerOne;
			textReady.defaultTextFormat = formatReady;
			
			textReady.width = 300;
			textReady.height = 100;
			
			textPlayerOne.width = 300;
			textPlayerOne.height = 100;
			
			textPlayerOne.text = "PLAYER ONE";
			textReady.text = "READY!";
			
			textPlayerOne.textColor = 0xff00ffff;
			textReady.textColor = 0xffffff00;
			
			textPlayerOne.defaultTextFormat = formatPlayerOne;
			textReady.defaultTextFormat = formatReady;
			
			textPlayerOne.x = 11 * TileClass.tileWidth;
			textReady.x = 12 * TileClass.tileWidth;
			
			textPlayerOne.y = 14 * TileClass.tileHeight;
			textReady.y = 20 * TileClass.tileHeight;
			
			addChild(pBackground);
			addChild(tiles);
			addChild(interfaceDesign);
			
			addChild(textPlayerOne);
			addChild(textReady);
			
			pObject.playerDead = true;
			
			var startTimer:Timer = new Timer(3000, 1);
			startTimer.addEventListener(TimerEvent.TIMER_COMPLETE, addEverything);
			startTimer.start();
			
			addEventListener(Player.SET_SCARED, setScared);
		}
		
		private function setScared(e:Event):void
		{
			blinky.isNotSpawned = true;
			pinky.isNotSpawned = true;
			inky.isNotSpawned = true;
			clyde.isNotSpawned = true;
		}
		
		public static function addMyChild(x:int, y:int,sprite:Sprite, stage:Stage):void
		{
			sprite.x = x;
			sprite.y = y;
			stage.addChild(sprite);
			
			var tTimer:Timer = new Timer(1000, 1);
			tTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e:Event):void { removeScore(sprite, stage) } );
			tTimer.start()
		}
		
		static private function removeScore(sprite:Sprite, stage:Stage):void 
		{
			stage.removeChild(sprite);
		}
		
		
		private function addEverything(e:TimerEvent):void
		{
			var readyTimer:Timer = new Timer(1216, 1);
			readyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startGame);
			readyTimer.start();
			removeChild(textPlayerOne);
			
			addChild(fruits);
			addChild(blinky);
			addChild(pinky);
			addChild(inky);
			addChild(clyde);
			addChild(player);
		}
		
		private function startGame(e:TimerEvent):void
		{
			pObject.playerDead = false;
			removeChild(textReady);
			
			var timer:Timer = new Timer(5000, 0);
			timer.addEventListener(TimerEvent.TIMER, updateScore);
			timer.start();
			
			var time:Timer = new Timer(1000, 1);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, minusLife);
			time.start();
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(pObject.DESTROY_PLAYER, destroyPlayer);
		}
		
		private function destroyPlayer(e:Event):void
		{
			pObject.stopDeath = false;
			interfaceDesign.removeLife();
		}
		
		public static function setPlayerLocation():void
		{
			player.x = 14 * TileClass.tileWidth; //14
			player.y = 26 * TileClass.tileHeight; //26
		}
		
		private function update(e:Event):void
		{
			CheckLevel();
			CheckGhosts();
			CheckDots();
		}
		
		private function CheckDots():void 
		{
			if (eatenDots == 70) //70
			{
				fruits.changeFruit(level);
			}
			else if (eatenDots == 170) //170
			{
				fruits.changeFruit(level);
			}
		}
		
		private function CheckGhosts():void
		{
			if (pObject.playerDead == true)
			{
				if (blinky != null && pinky != null && inky != null && clyde != null)
				{
					blinky.parent.removeChild(blinky);
					pinky.parent.removeChild(pinky);
					inky.parent.removeChild(inky);
					clyde.parent.removeChild(clyde);
				}
				
				blinky.x = 14 * TileClass.tileWidth; //14
				pinky.x = 14 * TileClass.tileWidth; //14
				inky.x = 12 * TileClass.tileWidth; //14
				clyde.x = 16 * TileClass.tileWidth; //14
				
				blinky.y = 14 * TileClass.tileHeight; //14
				pinky.y = 17 * TileClass.tileHeight; //14
				inky.y = 17 * TileClass.tileHeight; //14
				clyde.y = 17 * TileClass.tileHeight; //14
				
				addChild(blinky);
				addChild(pinky);
				addChild(inky);
				addChild(clyde);
				pObject.playerDead = false;
			}
		}
		
		private function minusLife(e:TimerEvent):void
		{
			interfaceDesign.removeLife();
		}
		
		private function updateScore(e:TimerEvent):void
		{
			DataClass.updateScore();
		}
		
		private function CheckLevel():void
		{
			if (TileClass.smallPoints.length <= 0 && TileClass.bigPoints.length <= 0 && levelCheck == true)
			{
				pBackground.start();
				levelCheck = false;
				level++;
				eatenDots = 0;
				TileClass.spawnCookies = true;
				InterfaceDesign.updateFruit = true;
				player.x = 14 * TileClass.tileWidth;
				player.y = 26 * TileClass.tileHeight;
				
				var time:Timer = new Timer(1000, 1);
				time.addEventListener(TimerEvent.TIMER_COMPLETE, stop);
				time.start();
			}
		}
		
		private function stop(e:TimerEvent):void 
		{
			pBackground.stop();
		}
		
		public static function addScore(amount:uint):void
		{
			DataClass.score += amount;
		}
	
	}

}