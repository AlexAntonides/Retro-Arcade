package pickups
{
	import flash.display.Sprite;
	import flash.events.Event;
	import assets.Assets;
	import flash.events.TimerEvent;
	import background.TileClass;
	import flash.utils.Timer;
	import screens.GameScreen;
	import uid.InterfaceDesign;
	import uid.DataClass;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Fruit extends PickUp
	{
		public var fruitNumber:uint = 1;
		public var scoreValue:uint = 100;
		
		private var timer:int = 0;
		private var count:int = 0;
		
		private var cherry:Sprite = Assets.InstantiateSprite(Assets.ASSET_CHERRY);
		private var strawberry:Sprite = Assets.InstantiateSprite(Assets.ASSET_STRAWBERRY);
		private var peach:Sprite = Assets.InstantiateSprite(Assets.ASSET_PEACH);
		private var apple:Sprite = Assets.InstantiateSprite(Assets.ASSET_APPLE);
		private var lime:Sprite = Assets.InstantiateSprite(Assets.ASSET_LIME);
		private var galaxian:Sprite = Assets.InstantiateSprite(Assets.ASSET_GALAXIAN);
		private var bell:Sprite = Assets.InstantiateSprite(Assets.ASSET_BELL);
		private var key:Sprite = Assets.InstantiateSprite(Assets.ASSET_KEY);
		
		private var takeable:Boolean = false;
		
		private var container:Sprite = new Sprite();
		
		private var score:Sprite;
		
		private var functie:int;
		
		public function Fruit(_functie:int = 1)
		{
			functie = _functie;
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addChild(cherry);
			addChild(strawberry);
			addChild(peach);
			addChild(apple);
			addChild(lime);
			addChild(galaxian);
			addChild(bell);
			addChild(key);
			
			addChild(container);
			container.addChild(cherry);
			container.addChild(strawberry);
			container.addChild(peach);
			container.addChild(apple);
			container.addChild(lime);
			container.addChild(galaxian);
			container.addChild(bell);
			container.addChild(key);
			
			hideAllAssets(cherry, strawberry, peach, apple, lime, galaxian, bell, key);
			
			if (functie == 1)
			{
				addEventListener(Event.ENTER_FRAME, loop);
			}
		}
		
		private function loop(e:Event):void
		{
			if (takeable)
			{
				if (this.hitTestObject(GameScreen.player))
				{
					takeable = false;
					this.visible = false;
					Assets.PlaySound(Assets.SOUND_EAT_FRUIT);
					DataClass.score += scoreValue;
					
					if (scoreValue == 100)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_100);
					}
					else if (scoreValue == 300)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_300);
					}
					else if (scoreValue == 500)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_500);
					}
					else if (scoreValue == 700)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_700);
					}
					else if (scoreValue == 1000)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_1000);
					}
					else if (scoreValue == 2000)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_2000);
					}
					else if (scoreValue == 3000)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_3000);
					}
					else if (scoreValue == 5000)
					{
						score = Assets.InstantiateSprite(Assets.ASSET_EAT_FRUIT_5000);
					}
					
					GameScreen.addMyChild(14 * TileClass.tileWidth, 20 * TileClass.tileHeight, score, stage); 
				}
				
				timer++;
				
				if (timer == 30)
				{
					count++;
					timer = 0;
				}
				if (count == randomRange(9, 10))
				{
					this.visible = false;
					takeable = false;
					count = 0;
					trace(this.visible);
				}
			}
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function changeFruit(number:uint):void
		{
			if (number == 1)
			{
				this.visible = true;
				cherry.visible = true;
				hideAllAssets(strawberry, peach, apple, lime, galaxian, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 2)
			{
				this.visible = true;
				strawberry.visible = true;
				hideAllAssets(cherry, peach, apple, lime, galaxian, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 3)
			{
				this.visible = true;
				peach.visible = true;
				hideAllAssets(cherry, strawberry, apple, lime, galaxian, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 4)
			{
				this.visible = true;
				apple.visible = true;
				hideAllAssets(cherry, strawberry, peach, lime, galaxian, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 5)
			{
				this.visible = true;
				lime.visible = true;
				hideAllAssets(cherry, strawberry, peach, apple, galaxian, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 6)
			{
				this.visible = true;
				galaxian.visible = true;
				hideAllAssets(cherry, strawberry, peach, apple, lime, bell, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 7)
			{
				this.visible = true;
				bell.visible = true;
				hideAllAssets(cherry, strawberry, peach, apple, lime, galaxian, key);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
			else if (number == 8)
			{
				this.visible = true;
				key.visible = true;
				hideAllAssets(cherry, strawberry, peach, apple, lime, galaxian, bell);
				if (functie == 1)
				{
					changeScore();
					takeable = true;
				}
			}
		}
		
		private function hideAllAssets(... assets):void
		{
			for each (var sprite:Sprite in assets)
			{
				sprite.visible = false;
			}
		}
		
		public function changeScore():void
		{
			if (fruitNumber == 1)
			{
				scoreValue = 100;
			}
			else if (fruitNumber == 2)
			{
				scoreValue == 300; // ?
			}
			else if (fruitNumber == 3)
			{
				scoreValue == 500; // ?
			}
			else if (fruitNumber == 4)
			{
				scoreValue == 700; // ?
			}
			else if (fruitNumber == 5)
			{
				scoreValue == 1000; // ?
			}
			else if (fruitNumber == 6)
			{
				scoreValue == 2000; // ?
			}
			else if (fruitNumber == 7)
			{
				scoreValue == 3000; // ?
			}
			else if (fruitNumber == 8)
			{
				scoreValue == 5000; // ?
			}
		}
	
	}

}