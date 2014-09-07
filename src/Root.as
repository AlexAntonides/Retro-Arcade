package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.GameScreen;
	import screens.MenuScreen;
	import screens.Screen;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Root extends Sprite
	{
		private var screen_Game:GameScreen;
		private var screen_Menu:MenuScreen;
		private var _screen:Screen;
		public function Root() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			placeScreen("inGame");
		}
		
		private function placeScreen(type:String):void
		{
			switch(type)
			{
				case "start":
					_screen = new MenuScreen();
					_screen.addEventListener(MenuScreen.START_GAME, startGame);
					break;
				case "inGame":
					_screen = new GameScreen();
					_screen.addEventListener(GameScreen.END_GAME, endGame);
					break;
			}
			addChild(_screen);
		}
		
		private function startGame(e:Event):void
		{
			destroy();
			placeScreen("inGame");
		}
		
		private function endGame(e:Event):void
		{
			destroy();
			placeScreen("start");
		}
		
		private function destroy():void
		{
			removeChild(_screen);
		}
	}

}