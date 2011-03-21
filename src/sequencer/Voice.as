
/**		
 * 
 *	sequencer.Voice
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import test.effects.Delay;
	import test.poly.SimplePolySynthVoiceFactory;

	import tonfall.core.BlockInfo;
	import tonfall.core.Engine;
	import tonfall.core.Processor;
	import tonfall.core.TimeConversion;
	import tonfall.core.TimeEventNote;
	import tonfall.poly.PolySynth;

	/**
	 * Voice
	 */
	public class Voice extends Processor 
	{
		private var _generator : PolySynth = new PolySynth(SimplePolySynthVoiceFactory.INSTANCE);
		private var _delay : Delay = new Delay(TimeConversion.barsToMillis(3.0 / 16.0, Engine.getInstance().bpm));
		private var _queue : Vector.<int> = new Vector.<int>();

		public function Voice()
		{
			super();
			
			engine.processors.push(this);
			engine.processors.push(_generator);
			engine.processors.push(_delay);

			_delay.input = _generator.output;
			engine.input = _delay.output;
		}

		public function queue(note : int) : void
		{
			_queue.push(note);
		}

		override public function process(info : BlockInfo) : void 
		{
			var index : int = int(info.from * 16.0);
			var position : Number = index / 16.0;
		
			while( position < info.to )
			{
				if( position >= info.from )
				{
					for (var i : int = 0;i < _queue.length;i++)
					{
						var event : TimeEventNote = new TimeEventNote();
					
						event.position = position;
						event.note = _queue[i];
						event.duration = 1.0 / 16.0;
						_generator.addTimeEvent(event);
					}
				
					_queue.length = 0;
				}

				position += 1.0 / 16.0;
				++index;
			}
		}
	}
}
