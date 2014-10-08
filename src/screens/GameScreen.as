package screens 
{
	import background.GameBackground;
	import background.TileClass;
	import flash.events.Event;
	import objects.Blinky;
	import objects.Clyde;
	import objects.Inky;
	import objects.Pinky;
	import objects.Player;
	import objects.pObject;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class GameScreen extends Screen 
	{
		static public const END_GAME:String = "endGame";
		
		private var tiles:TileClass = new TileClass();
		public static var player:Player = new Player();
		private var pBackground:Background = new Background();
		
		private var blinky:Blinky = new Blinky();
		private var pinky:Pinky = new Pinky();
		private var inky:Inky = new Inky();
		private var clyde:Clyde = new Clyde();
		
		public static var score:uint;
		public static var level:uint = 1;
		
		private var levelCheck:Boolean = true;
		
		public function GameScreen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			pBackground.x = 10;
			player.x = 14 * TileClass.tileWidth; //14
			blinky.x = 14 * TileClass.tileWidth; //14
			pinky.x = 14 * TileClass.tileWidth; //14
			inky.x = 12 * TileClass.tileWidth; //14
			clyde.x = 16 * TileClass.tileWidth; //14
			
			pBackground.y = 60;
			player.y = 26 * TileClass.tileHeight; //26
			blinky.y = 14 * TileClass.tileHeight; //14
			pinky.y = 17 * TileClass.tileHeight; //14
			inky.y = 17 * TileClass.tileHeight; //14
			clyde.y = 17 * TileClass.tileHeight; //14
			
			addChild(pBackground);
			addChild(tiles);
			addChild(blinky);
			addChild(pinky);
			addChild(inky);
			addChild(clyde);
			addChild(player);
			
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(pObject.DESTROY_PLAYER, destroyPlayer);
		}
		
		private function destroyPlayer(e:Event):void 
		{
			player.visible = false;
			//player.parent.removeChild(player);
		}
		
		private function update(e:Event):void
		{
			CheckLevel();
		}
		
		private function CheckLevel():void 
		{
			if (TileClass.smallPoints.length <= 0 && TileClass.bigPoints.length <= 0 && levelCheck == true)
			{
				level++;
				trace("Level: " + level);
				levelCheck = false;
			}
		}
		
		public static function addScore(amount:uint):void
		{
			GameScreen.score += amount;
			trace(GameScreen.score);
		}
		
	}

}