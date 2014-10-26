package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	 [SWF(backgroundColor = "#000000")]
	public class Main extends Sprite 
	{
		private var _root:Root;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_root = new Root();
			addChild(_root);
		}
		
	}
	
}