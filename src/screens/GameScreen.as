package screens 
{
	import background.GameBackground;
	import flash.events.Event;
	import objects.Player;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class GameScreen extends Screen 
	{
		static public const END_GAME:String = "endGame";
		
		private var pPlayer:Player;
		private var pBackground:GameBackground;
		public function GameScreen() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			pPlayer = new Player();
			pBackground = new GameBackground();
			
			pPlayer.x = 500;
			pBackground.x = 400;
			
			pPlayer.y = 500;
			pBackground.y = 270;
			
			addChild(pPlayer);
			addChild(pBackground);
		}
		
	}

}