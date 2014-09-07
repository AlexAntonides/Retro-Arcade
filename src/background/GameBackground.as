package background 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class GameBackground extends Sprite 
	{
		private var wall:wallBackground;
		public function GameBackground() 
		{
			wall = new wallBackground();
			
			addChild(wall);
		}
		
	}

}