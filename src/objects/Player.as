package objects 
{
	import flash.display.MovieClip;
	import flash.display.Sprite
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Alex Antonides
	 */
	public class Player extends MovieClip
	{
		private var leftAnim:MovieClip;
		private var rightAnim:MovieClip;
		private var upAnim:MovieClip;
		private var downAnim:MovieClip;
		private var idleAnim:MovieClip;
		
		private var directionX:int = 0;
		private var directionY:int = 0;
		private var speed:Number = 3;
		
		public function Player() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			leftAnim = new leftCharacter();
			rightAnim = new rightCharacter();
			upAnim = new upCharacter();
			downAnim = new downCharacter();
			idleAnim = new idleCharacter();
			
			addChild(leftAnim);
			addChild(rightAnim);
			addChild(upAnim);
			addChild(downAnim);
			addChild(idleAnim);
			
			hideAllAnimations(rightAnim, upAnim, downAnim, idleAnim);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			this.x += speed * directionX; 
			this.y += speed * directionY; 
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) // Left
			{
				playAnimation(0);
				directionX = -1;
				directionY = 0;
			}
			if (e.keyCode == 39) // Right
			{
				playAnimation(1);
				directionX = 1;
				directionY = 0;
			}
			if (e.keyCode == 38) // Up
			{
				playAnimation(2);
				directionX = 0;
				directionY = -1;
			}
			if (e.keyCode == 40) // Down
			{
				playAnimation(3);
				directionX = 0;
				directionY = 1;
			}
		}
		
		private function playAnimation(animNr:int):void
		{
			switch(animNr)
			{
				case 0: // Left
				{
					hideAllAnimations(rightAnim, upAnim, downAnim, idleAnim);
					leftAnim.visible = true;
				}
					break;
				case 1: // Right
				{
					hideAllAnimations(leftAnim, upAnim, downAnim, idleAnim);
					rightAnim.visible = true;
				}
					break;
				case 2: // Up
				{
					hideAllAnimations(leftAnim, rightAnim, downAnim, idleAnim);
					upAnim.visible = true;	
				}
					break;
					
				case 3: // Down
				{
					hideAllAnimations(leftAnim, rightAnim, upAnim, idleAnim);
					downAnim.visible = true;
				}
					break;
			}
		}
		
		private function hideAllAnimations(Anim1:MovieClip, Anim2:MovieClip, Anim3:MovieClip, Anim4:MovieClip):void
		{
			Anim1.visible = false;
			Anim2.visible = false;
			Anim3.visible = false;
			Anim4.visible = false;
		}
		
	}

}