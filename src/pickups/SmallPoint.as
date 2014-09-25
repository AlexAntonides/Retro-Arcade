package pickups 
{
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class SmallPoint extends PickUp
	{
		public var score:int = 10;
		private var asset:smallPoint = new smallPoint();
		public function SmallPoint() 
		{
			addChild(asset);
		}
		
	}

}