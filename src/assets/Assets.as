package assets 
{
	import background.TileClass;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.text.Font;
	import pickups.LargePoint;
	import pickups.SmallPoint;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Assets 
	{
		public static const ANIM_START				: String     = "anim_start";
		
		public static const FONT_SCORE	 			: String	 = "asset_score";
		public static const FONT_HIGHSCORE			: String	 = "asset_highscore";
		
		public static const ASSET_LIVES 			: String	 = "asset_lives";
		public static const ASSET_DEATH_1  			: String     = "asset_death_1";
		public static const ASSET_DEATH_2  			: String     = "asset_death_2";
		public static const ASSET_EYES_UP			: String 	 = "asset_eyes_up";
		public static const ASSET_EYES_DOWN			: String 	 = "asset_eyes_down";
		public static const ASSET_EYES_LEFT			: String 	 = "asset_eyes_left";
		public static const ASSET_EYES_RIGHT		: String 	 = "asset_eyes_right";
		
		public static const ASSET_CHERRY			: String 	 = "asset_cherry";
		public static const ASSET_STRAWBERRY		: String 	 = "asset_strawberry";
		public static const ASSET_PEACH				: String 	 = "asset_peach";
		public static const ASSET_APPLE				: String 	 = "asset_apple";
		public static const ASSET_LIME				: String 	 = "asset_lime";
		public static const ASSET_GALAXIAN			: String 	 = "asset_galaxian";
		public static const ASSET_BELL				: String 	 = "asset_bell";
		public static const ASSET_KEY				: String 	 = "asset_key";
		
		public static const ASSET_EAT_GHOST_200 	: String 	 = "asset_eat_ghost_200";
		public static const ASSET_EAT_GHOST_400 	: String 	 = "asset_eat_ghost_400";
		public static const ASSET_EAT_GHOST_800 	: String 	 = "asset_eat_ghost_800";
		public static const ASSET_EAT_GHOST_1600 	: String 	 = "asset_eat_ghost_1600";
		public static const ASSET_EAT_GHOST_3200 	: String 	 = "asset_eat_ghost_3200";
		
		public static const ASSET_EAT_FRUIT_100 	: String 	 = "asset_eat_fruit_100";
		public static const ASSET_EAT_FRUIT_300 	: String 	 = "asset_eat_fruit_300";
		public static const ASSET_EAT_FRUIT_500 	: String 	 = "asset_eat_fruit_500";
		public static const ASSET_EAT_FRUIT_700 	: String 	 = "asset_eat_fruit_700";
		public static const ASSET_EAT_FRUIT_1000 	: String 	 = "asset_eat_fruit_1000";
		public static const ASSET_EAT_FRUIT_2000 	: String 	 = "asset_eat_fruit_2000";
		public static const ASSET_EAT_FRUIT_3000 	: String 	 = "asset_eat_fruit_3000";
		public static const ASSET_EAT_FRUIT_5000 	: String 	 = "asset_eat_fruit_5000";
		
		public static const SOUND_EXTRA_PACMAN		: String 	 = "sound_extra_pacman";
		public static const SOUND_EAT_GHOST			: String 	 = "sound_eat_ghost";
		public static const SOUND_EAT_FRUIT			: String 	 = "sound_eat_fruit";
		public static const SOUND_DEATH				: String 	 = "sound_death";
		public static const SOUND_CHOMP				: String 	 = "sound_chomp";
		public static const SOUND_BEGINNING			: String 	 = "sound_beginning";
		public static const SOUND_SIREN				: String 	 = "sound_siren";
		public static const SOUND_SCAREDSIREN       : String     = "sound_scaredsiren";
		public static const SOUND_EYESSIREN       	: String     = "sound_eyessiren";
		
		public static function InstantiateSprite( type : String ) : Sprite
		{
			var asset : Sprite;
			
			if (type == ASSET_DEATH_1)
			{
				asset = new AssetDeath1;
			}
			else if (type == ASSET_DEATH_2)
			{
				asset = new AssetDeath2;
			}
			else if (type == ASSET_EYES_UP)
			{
				asset = new AssetEyesU;
			}
			else if (type == ASSET_EYES_DOWN)
			{
				asset = new AssetEyesD;
			}
			else if (type == ASSET_EYES_LEFT)
			{
				asset = new AssetEyesL;
			}
			else if (type == ASSET_EYES_RIGHT)
			{
				asset = new AssetEyesR;
			}
			else if (type == ASSET_EAT_GHOST_200)
			{
				asset = new Asset_EatGhost_200;
			}
			else if (type == ASSET_EAT_GHOST_400)
			{
				asset = new Asset_EatGhost_400;
			}
			else if (type == ASSET_EAT_GHOST_800)
			{
				asset = new Asset_EatGhost_800;
			}
			else if (type == ASSET_EAT_GHOST_1600)
			{
				asset = new Asset_EatGhost_1600;
			}
			else if (type == ASSET_EAT_GHOST_3200)
			{
				asset = new Asset_EatGhost_3200;
			}
			else if (type == ASSET_CHERRY)
			{
				asset = new AssetCherry;
			}
			else if (type == ASSET_APPLE)
			{
				asset = new AssetApple;
			}
			else if (type == ASSET_BELL)
			{
				asset = new AssetBell;
			}
			else if (type == ASSET_GALAXIAN)
			{
				asset = new AssetGalaxian;
			}
			else if (type == ASSET_LIME)
			{
				asset = new AssetLime;
			}
			else if (type == ASSET_KEY)
			{
				asset = new AssetKey;
			}
			else if (type == ASSET_PEACH)
			{
				asset = new AssetPeach;
			}
			else if (type == ASSET_STRAWBERRY)
			{
				asset = new AssetStrawberry;
			}
			else if (type == ASSET_EAT_FRUIT_100)
			{
				asset = new Asset_EatFruit_100;
			}
			else if (type == ASSET_EAT_FRUIT_300)
			{
				asset = new Asset_EatFruit_300;
			}
			else if (type == ASSET_EAT_FRUIT_500)
			{
				asset = new Asset_EatFruit_500;
			}
			else if (type == ASSET_EAT_FRUIT_700)
			{
				asset = new Asset_EatFruit_700;
			}
			else if (type == ASSET_EAT_FRUIT_1000)
			{
				asset = new Asset_EatFruit_1000;
			}
			else if (type == ASSET_EAT_FRUIT_2000)
			{
				asset = new Asset_EatFruit_2000;
			}
			else if (type == ASSET_EAT_FRUIT_3000)
			{
				asset = new Asset_EatFruit_3000;
			}
			else if (type == ASSET_EAT_FRUIT_5000)
			{
				asset = new Asset_EatFruit_5000;
			}
			else
			{
				throw new Error("Invalid type specified in Assets class: InstantiateSprite. Type = " + type);
				return null;
			}
			
			return asset;
		}
		
		public static function InstantiateMovieclip ( type : String ) : MovieClip
		{
			var asset : MovieClip;
			
			if (type == ANIM_START)
			{
				asset = new StartAnimation;
			}
			else
			{
				throw new Error("Invalid type specified in Assets class: InstantiateSprite.");
				return null;
			}
			
			return asset;
		}
		
		public static function PlaySound (type:String, sc:SoundChannel = null, st:SoundTransform = null, sTime:int = 1, loops:int = 1):SoundChannel
		{
			var sound:Sound; 
			
			sc = new SoundChannel;
			
			if (type == SOUND_BEGINNING)
			{
				sound = new Sound_Beginning;
			}
			else if (type == SOUND_CHOMP)
			{
				sound = new Sound_Chomp3;
			}
			else if (type == SOUND_DEATH)
			{
				sound = new Sound_Death;
			}
			else if (type == SOUND_EAT_FRUIT)
			{
				sound = new Sound_Eat_Fruit;
			}
			else if (type == SOUND_EAT_GHOST)
			{
				sound = new Sound_Eat_Ghost;
			}
			else if (type == SOUND_EXTRA_PACMAN)
			{
				sound = new Sound_Extra_Pac;
			}
			else if (type == SOUND_SIREN)
			{
				sound = new Sound_Siren2;
			}
			else if (type == SOUND_SCAREDSIREN)
			{
				sound = new Sound_SirenScared;
			}
			else if (type == SOUND_EYESSIREN)
			{
				sound = new Sound_Siren;
			}
			else 
			{
				throw new Error("Invalid type specified in Assets Class: PlaySound.");
				return null;
			}
			
			sc = sound.play(sTime, loops, st);
			
			return sc;
		}
		
		public static function InstantiateFont ( type : String ) : Font
		{
			var font : Font;
			
			if (type == FONT_SCORE)
			{
				font = new MyFont();
			}
			else if (type == FONT_HIGHSCORE)
			{
				font = new MyFont();
			}
			else 
			{
				throw new Error("Invalid type specified in Assets Class: InstantiateFont.");
				return null;
			}
			
			return font;
		}
		
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