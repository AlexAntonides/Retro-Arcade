package uid
{
	import flash.display.Sprite;
	import flash.events.Event;
	import background.TileClass;
	import assets.Assets;
	import flash.geom.Point;
	import screens.GameScreen;
	import flash.events.TimerEvent;
	import objects.Player;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import pickups.Fruit;
	
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class InterfaceDesign extends Sprite
	{
		public static const GAME_OVER : String = "game_over";
		public static const PLAY_DEATH_ANIMATION : String = "play_death_animation";
		
		private var fontScore:Font = Assets.InstantiateFont(Assets.FONT_SCORE);
		private var fontHighScore:Font = Assets.InstantiateFont(Assets.FONT_HIGHSCORE);
		
		private var textHighScore:TextField = new TextField();
		private var textScore:TextField = new TextField();
		private var scoreText:TextField = new TextField();
		private var highScoreText:TextField = new TextField();
		
		private var formatHighScore:TextFormat = new TextFormat();
		private var formatScore:TextFormat = new TextFormat();
		private var highScoreformat:TextFormat = new TextFormat();
		private var scoreformat:TextFormat = new TextFormat();
		
		public static var totalLives:uint = 3;
		private var lives:Array = [];
		private var exist:Boolean = false;
		
		private var flickerTime:uint = 300;
		
		private var position:Point;
		
		public static var updateFruit:Boolean = true;
		
		public function InterfaceDesign()
		{
			if (stage)
				CreateUI();
			else
				addEventListener(Event.ADDED_TO_STAGE, CreateUI);
		}
		
		private function CreateUI(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, CreateUI);
			
			CreateScores();
			
			for (var i:int = 0; i < totalLives; i++)
			{
				var life:LifeAsset = new LifeAsset();
				addChild(life);
				lives.push(life);
			}
			
			for (var j:int = 0; j < lives.length; j++)
			{
				var asset_life:LifeAsset = new LifeAsset();
				
				lives[0].x = 50;
				lives[0].y = stage.stageHeight - asset_life.height * 2;
				lives[1].x = 80;
				lives[1].y = stage.stageHeight - asset_life.height * 2;
				lives[2].x = 110;
				lives[2].y = stage.stageHeight - asset_life.height * 2;
			}
			
			addChild(textHighScore);
			addChild(textScore);
			addChild(highScoreText);
			addChild(scoreText);
			
			var timer:Timer = new Timer(100, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
			timer.start();
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function removeLife():void
		{
			var isLifeGone:Boolean = false;
			totalLives--;
			for (var i:int = 0; i < lives.length; i++)
			{
				if (totalLives == 2 && isLifeGone == false)
				{
					isLifeGone = true;
					lives[2].visible = false;
					trace("Two Lives Left");
				}
				else if (totalLives == 1 && isLifeGone == false)
				{
					isLifeGone = true;
					lives[1].visible = false;
					dispatchEvent(new Event(PLAY_DEATH_ANIMATION, true));
					trace("One Life Left");
				}
				else if (totalLives == 0 && isLifeGone == false)
				{
					isLifeGone = true;
					lives[0].visible = false;
					trace("Game Over");
					dispatchEvent(new Event(PLAY_DEATH_ANIMATION, true));
					dispatchEvent(new Event(GAME_OVER, true));
				}
			}
		}
		
		private function CreateScores():void 
		{
			formatHighScore.font = fontHighScore.fontName;
			formatScore.font = fontScore.fontName;
			
			textHighScore.text = "HIGH SCORE";
			textScore.text = "1UP";
			
			textHighScore.textColor = 0xFFFFFFFF;
			textScore.textColor = 0xFFFFFFFF;
			scoreText.textColor = 0xFFFFFFFF;
			highScoreText.textColor = 0xFFFFFFFF;
			
			textHighScore.defaultTextFormat = formatHighScore;
			textScore.defaultTextFormat = formatScore;
			scoreText.defaultTextFormat = scoreformat;
			highScoreText.defaultTextFormat = highScoreformat;
			
			textHighScore.x = 170;
			textScore.x = 60;
			scoreText.x = 67.5;
			highScoreText.x = 205;
			
			textHighScore.y = 10; 
			textScore.y = 10;
			scoreText.y = 20;
			highScoreText.y = 20;
		}
		
		private function loop(e:Event):void
		{
			scoreText.text = String(DataClass.score);
			highScoreText.text = String(DataClass.highScore);
			if (DataClass.score >= DataClass.highScore)
			{
				DataClass.updateHighScore(DataClass.score);
			}
			
			UpdateFruits();
		}
		
		private function UpdateFruits():void 
		{
			if (updateFruit)
			{
				updateFruit = false;
				
				var fruits:Sprite;
				
				if (exist == false)
				{
					exist = true;
					fruits = newFruit();
					
					fruits.x  = 24 * TileClass.tileWidth; // 24
					fruits.y  = 34.7 * TileClass.tileHeight; // 34.7
					
					position = new Point(24 * TileClass.tileWidth, 34.7 * TileClass.tileHeight);
				}
				else
				{
					fruits = newFruit();
					
					fruits.x = position.x - 2 * TileClass.tileWidth;
					fruits.y = position.y;
					
					position.x = fruits.x;
					position.y = fruits.y;
				}
				
				addChild(fruits);
			}
		}
		
		private function newFruit():Sprite
		{
			var fruit:Sprite;
			if (GameScreen.level == 1)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_CHERRY);
			}
			else if (GameScreen.level == 2)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_STRAWBERRY);
			}
			else if (GameScreen.level == 3)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_PEACH);
			}
			else if (GameScreen.level == 4)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_APPLE);
			}
			else if (GameScreen.level == 5)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_LIME);
			}
			else if (GameScreen.level == 6)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_GALAXIAN);
			}
			else if (GameScreen.level == 7)
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_BELL);
			}
			else
			{
				fruit = Assets.InstantiateSprite(Assets.ASSET_KEY);
			}
			return fruit;
		}
		
		private function onTrue(e:TimerEvent):void
		{
			if (textScore.visible == true)
			{
				textScore.visible = false;
			}
			
			var timer:Timer = new Timer(flickerTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onFalse);
			timer.start();
		}
		
		private function onFalse(e:TimerEvent):void
		{
			if (textScore.visible == false)
			{
				textScore.visible = true;
			}
			
			var timer:Timer = new Timer(flickerTime, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTrue);
			timer.start();
		}
	
	}

}