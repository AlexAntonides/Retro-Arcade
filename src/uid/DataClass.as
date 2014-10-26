package uid 
{
	import flash.net.SharedObject;
	import flash.events.Event;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class DataClass
	{
		public static var sharedObject:SharedObject = SharedObject.getLocal("highScores");
		public static var score:uint = 00;
		public static var highScore:uint = sharedObject.data.highScores;
		
		public static function updateScore():void
		{
			DataClass.sharedObject.data.highScore = DataClass.highScore; 
			DataClass.sharedObject.flush();
		}
		
		public static function updateHighScore(score:uint):void
		{
			if (score >= DataClass.highScore)
			{
				DataClass.highScore = score;
			}
		}
	}

}