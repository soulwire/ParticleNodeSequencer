
/**		
 * 
 *	sequencer.Synapse
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * Synapse
	 */
	public class Synapse extends Sprite 
	{
		public var input : Node;
		public var output : Node;
		
		private var _timeout : uint;
		
		public function Synapse(__input : Node, __output : Node)
		{
			input = __input;
			output = __output;
			mouseEnabled = mouseChildren = false;
			
			blendMode = BlendMode.ADD;
		}

		public function fire() : void
		{
			var dx : Number = output.x - input.x;			var dy : Number = output.y - input.y;
			var len : Number = Math.sqrt(dx * dx + dy * dy);
			
			_timeout = setTimeout(pulse, len * 5, input.data);
		}
		
		private function pulse(data : Object) : void
		{
			output.pulse(data);
		}

		public function draw() : void
		{
			graphics.clear();
			
			var dx : Number = output.x - input.x;
			var dy : Number = output.y - input.y;
			var dSq : Number = dx * dx + dy * dy;
			alpha = 1 - (dSq / Config.MIN_PROXIMITY_SQ);
			
			graphics.lineStyle(12, 0xFFFFFF, 0.1);
			graphics.moveTo(input.x, input.y);
			graphics.lineTo(output.x, output.y);
			
			graphics.lineStyle(1, 0xFFFFFF, 0.4);
			graphics.moveTo(input.x, input.y);
			graphics.lineTo(output.x, output.y);
			
			graphics.beginFill(0xFFFFFF, 0.6);
			graphics.drawCircle(input.x, input.y, 2);
			graphics.endFill();
			
			graphics.beginFill(0xFFFFFF, 0.6);
			graphics.drawCircle(output.x, output.y, 2);
			graphics.endFill();
			
			//trace(input, output);
		}

		public function destroy() : void
		{
			if(_timeout)
			{
				clearTimeout(_timeout);
			}
		}
	}
}
