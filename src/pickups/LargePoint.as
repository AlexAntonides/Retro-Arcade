package pickups 
{
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class LargePoint extends PickUp
	{
		public var score:int = 50;
		private var asset:bigPoint = new bigPoint();
		public function LargePoint() 
		{
			addChild(asset);
		}
		
	}

}