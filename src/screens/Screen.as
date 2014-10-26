package screens 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import uid.DataClass;
	import flash.net.SharedObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Screen extends Sprite
	{
		public static const GAMESCREEN			:uint = 0;
		public static const	MENUSCREEN			:uint = 1;
		
		public static const ADD_MENU	: String = "add_menu";
		public static const ADD_GAME	: String = "add_game";
		
		public static var currentScreen:Screen;
		
		public static var sharedObject:SharedObject = SharedObject.getLocal("highScores");
		public function Screen() 
		{
			var i:uint = sharedObject.data.highScore;
			DataClass.updateHighScore(i);
		}
		
		public function addScreen(screenType:uint, target:Stage):void
		{
			var screen:Screen = this.createScreen(screenType);
			currentScreen = screen;
			
			target.addChild(screen);
		}
		
		public function removeScreen(currentScreen:Screen, addGame:uint = 1):void
		{
			/* Op dit moment is het visible = false ipv delete. RemoveChild werkt niet, dus dit vanwege tijds problemen. */
			currentScreen.visible = false;
			
			if (addGame == 1)
			{
				dispatchEvent(new Event(ADD_GAME, true));
			}
			else if (addGame == 2)
			{
				dispatchEvent(new Event(ADD_MENU, true));
			}
		}
		
		private function createScreen(screenType:uint):Screen
		{
			switch(screenType)
			{
				case MENUSCREEN:
						return new MenuScreen();
					break;
					
				case GAMESCREEN:
						return new GameScreen();
					break;
				default:
					throw new Error("Invalid kind of screen specified");
					return null;
			}
		}
		
		public function getScreen():Screen
		{
			return currentScreen;
		}
	}

}