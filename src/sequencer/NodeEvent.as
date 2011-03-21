
/**		
 * 
 *	sequencer.NodeEvent
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import flash.events.Event;

	/**
	 * NodeEvent
	 */
	public class NodeEvent extends Event 
	{
		public static const PULSE : String = "pulse";
		
		public var data : Object;
		
		public function NodeEvent(type : String, data : Object, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}

		override public function clone() : Event 
		{
			return new NodeEvent(type, data, bubbles, cancelable);
		}
	}
}
