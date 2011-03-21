
/**		
 * 
 *	sequencer.Node
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import flash.display.Graphics;
	import math.random;

	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Node
	 */
	public class Node extends Sprite 
	{
		private static const TWO_PI : Number = Math.PI * 2.0;
		
		public var radius : Number = 0.0;
		public var pulseCut : Number = 0.55;
		public var colour : uint = 0xFFFFFF;
		public var data : Object = {};
		public var g : Graphics;
		
		private var _angle : Number = random(TWO_PI);
		private var _speed : Number = random(0.2, 1.5);
		private var _maxStep : Number = random(Math.PI * 0.15);
		
		protected var _graphics : Sprite = new Sprite();
		protected var _drag : Sprite = new Sprite();
		
		public function Node()
		{
			colour = Config.COLOURS[int(random(Config.COLOURS.length))];
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function init() : void
		{
			g = _graphics.graphics;
			
			//blendMode = BlendMode.ADD;
			x = random(stage.stageWidth);
			y = random(stage.stageHeight);
			
			_graphics.mouseEnabled = false;
			_graphics.mouseChildren = false;
			
			_drag.buttonMode = true;
			_drag.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			_drag.graphics.beginFill(0x0, 0);
			_drag.graphics.drawCircle(0, 0, radius + 4);
			_drag.graphics.endFill();
			
			addChild(_graphics);
			addChild(_drag);
		}

		public function pulse(params : Object = null) : void
		{
			dispatchEvent(new NodeEvent(NodeEvent.PULSE, params));
		}
		
		public function makePulse() : Shape
		{
			var p : Shape = new Shape();
			p.blendMode = BlendMode.ADD;
			
			p.graphics.beginFill(colour);
			p.graphics.drawCircle(0, 0, radius);
			p.graphics.drawCircle(0, 0, radius * pulseCut);
			p.graphics.endFill();
			p.alpha = 0.2;
			
			_graphics.addChildAt(p, 0);
			
			return p;
		}
		
		public function killPulse(p : Shape) : void
		{
			_graphics.removeChild(p);
			p = null;
		}

		public function draw() : void
		{
			g.clear();
			g.lineStyle(10, colour, 0.15);
			g.beginFill(colour, 0.8);
			g.drawCircle(0, 0, radius);
			g.endFill();
		}

		public function wander() : void
		{
			if(Config.WANDER)
			{
				_angle += random(-_maxStep, _maxStep);
				x += Math.cos(_angle) * _speed;
				y += Math.sin(_angle) * _speed;
				
				var w : int = Config.WIDTH;
				var h : int = Config.HEIGHT;
				
				x = x < 0 ? w : x > w ? 0 : x;
				y = y < 0 ? h : y > h ? 0 : y;
			}
		}

		public function destroy() : void
		{
			
		}

		//	----------------------------------------------------------------
		//	EVENT HANDLERS
		//	----------------------------------------------------------------
		
		private function onAddedToStage(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function onMouseDown(event : MouseEvent) : void 
		{
			startDrag();
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onMouseUp(event : MouseEvent) : void 
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	}
}
