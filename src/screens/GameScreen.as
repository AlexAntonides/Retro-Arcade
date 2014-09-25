package screens 
{
	import background.GameBackground;
	import background.TileClass;
	import flash.events.Event;
	import objects.Player;
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
			player.x = 14 * TileClass.tileWidth; //15
			
			pBackground.y = 60;
			player.y = 26 * TileClass.tileHeight; //20
			
			addChild(pBackground);
			addChild(tiles);
			addChild(player);
		}
		
	}

}