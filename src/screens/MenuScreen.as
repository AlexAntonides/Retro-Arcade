package screens 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class MenuScreen extends Screen 
	{
			static public const START_GAME:String = "startGame";
		/*
			private var button_Start:StartButton;
		*/
		public function MenuScreen() 
		{
			/*
				button_Start = new StartButton();
				
				button_Start.x = 400;
				
				button_Start.y = 300;
				
				addChild(button_Start);
				
				addEventListener(MouseEvent.CLICK, onClick);
			*/
		}
		/*
			private function onClick(e:MouseEvent):void
			{
				if (e.target == button_Start)
				{
					startGame();
				}
			}
			
			private function startGame():void
			{
				dispatchEvent(new Event(START_GAME));			
			}
		*/
	}

}