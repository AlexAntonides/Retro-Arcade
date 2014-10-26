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
		public function Root() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			placeScreen("start");
			
			stage.addEventListener(Screen.ADD_GAME, placeGame);
			stage.addEventListener(Screen.ADD_MENU, placeMenu);
		}
		
		private function placeScreen(type:String):void
		{
			var _screen:Screen = new Screen();
			
			switch(type)
			{
				case "start":
					_screen.addScreen(Screen.MENUSCREEN, this.stage);
					break;
				case "inGame":
					_screen.addScreen(Screen.GAMESCREEN, this.stage);
					break;
				default: 
					throw new Error("Invalid type specified at Root class.");
					return null;
			}
		}
		
		private function placeMenu(e:Event):void 
		{
			placeScreen("start");
		}
		
		private function placeGame(e:Event):void 
		{
			placeScreen("inGame");
		}
	}

}