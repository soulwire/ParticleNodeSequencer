
/**		
 * 
 *	sequencer.Receptor
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import math.random;

	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;

	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * Receptor
	 */
	public class Receptor extends Node 
	{		private static const SCALE : Vector.<int> = Vector.<int>([0,2,5,7,9,12,14,17]);
		private static const OCTAVE : int = 19;

		public var note : int = SCALE[int(random(SCALE.length))];

		public function Receptor()
		{
			super();
			
			blendMode = BlendMode.ADD;
			radius = 20 - ((note / 19) * 15);
			note += (OCTAVE * 3);
		}

		override public function init() : void 
		{
			super.init();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		override public function pulse(params : Object = null) : void 
		{
			super.pulse(params);
			
			TweenMax.killTweensOf(this);
			TweenMax.killDelayedCallsTo(this);
			
			var p : Shape = makePulse();
			TweenMax.to(p, 2.0, {
				scaleX:4.0,
				scaleY:4.0,
				alpha:0.0,
				ease:Expo.easeOut,
				onComplete:killPulse,
				onCompleteParams:[p]
				});
				
			TweenMax.to(this, 0.2, {scaleX:1.2, scaleY:1.2, colorMatrixFilter:{brightness:2.0}});
			TweenMax.to(this, 0.3, {scaleX:1.0, scaleY:1.0, colorMatrixFilter:{brightness:1.0}, delay:0.2});
		}
		
		override public function destroy() : void 
		{
			super.destroy();
			
			TweenMax.killTweensOf(this);
			TweenMax.killDelayedCallsTo(this);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void 
		{
			wander();
		}
	}
}
