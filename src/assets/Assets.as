package assets 
{
	import background.TileClass;
	import flash.display.Sprite;
	import pickups.LargePoint;
	import pickups.SmallPoint;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Assets 
	{
		
		public static function InstantiateTile(i:int, j:int, number:int = 0) : Sprite
		{
			var assetTile:Sprite;
			
			if (number == 1)
			{
				assetTile = new WalkTile();
			}
			else if (number == 2)
			{
				assetTile = new SmallPoint();
			}
			else if (number == 3)
			{
				assetTile = new LargePoint();
			}
			else 
			{
				assetTile = new Wall();
			}
			
			assetTile.x = j * TileClass.tileWidth;
			
			assetTile.y = i * TileClass.tileHeight;
			
			return assetTile;
		}
	}
}