
/**		
 * 
 *	sequencer.Neuron
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
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Neuron
	 */
	public class Neuron extends Node 
	{
		private static var COUNT : uint = 0;
		
		private var _timer : Timer;
		
		private var _inner : Shape = new Shape();
		private var _outer : Shape = new Shape();
		
		public function Neuron()
		{
			super();
			
			radius = 30;
			
			_outer.blendMode = BlendMode.ADD;
			_graphics.addChild(_outer);			_graphics.addChild(_inner);
		}
		
		override public function init() : void 
		{
			super.init();
			
			data.octave = (COUNT++) % 3;
			
			_timer = new Timer(random(600, 1200));
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void 
		{
			wander();
		}
	
		override public function pulse(params : Object = null) : void 
		{
			super.pulse(params);
			
			TweenMax.killTweensOf(this);
			TweenMax.killDelayedCallsTo(this);
			
			var p : Shape = makePulse();
			TweenMax.to(p, 5.0, {
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
		
		override public function draw() : void 
		{
			var len : int = 7;
			
			_inner.graphics.clear();
			_inner.graphics.lineStyle(3, colour);
			_inner.graphics.moveTo(-len, 0);			_inner.graphics.lineTo(len, 0);			_inner.graphics.moveTo(0, -len);			_inner.graphics.lineTo(0, len);
			
			_outer.graphics.clear();
			_outer.graphics.lineStyle(10, colour, 0.15);
			_outer.graphics.beginFill(colour, 0.8);
			_outer.graphics.drawCircle(0, 0, radius);
			_outer.graphics.endFill();
		}
		
		override public function destroy() : void 
		{
			super.destroy();
			
			TweenMax.killTweensOf(this);
			TweenMax.killDelayedCallsTo(this);
			
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer = null;
			
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onTimer(event : TimerEvent) : void 
		{
			pulse();
		}
	}
}
