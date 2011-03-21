package test.poly
{
	import tonfall.core.TimeConversion;
	import tonfall.core.Engine;
	import tonfall.core.Signal;
	import tonfall.core.TimeEvent;
	import tonfall.core.TimeEventNote;
	import tonfall.core.noteToFrequency;
	import tonfall.core.samplingRate;
	import tonfall.poly.IPolySynthVoice;
	import tonfall.util.WaveFunction;

	/**
	 * Test implementation of a polyphonic synthesizer voice
	 * 
	 * @author Andre Michelle
	 */
	public final class SimplePolySynthVoice
		implements IPolySynthVoice
	{
		private const volume: Number = 0.2;
		
		private const engine: Engine = Engine.getInstance();
		
		private var _phase: Number;
		private var _phaseIncr: Number;
		
		private var _duration: int;
		private var _remaining: int;

		public function start( event: TimeEvent ) : void
		{
			var noteEvent: TimeEventNote = TimeEventNote( event ); 
			
			_phase = 0.0;
			_phaseIncr = noteToFrequency( noteEvent.note ) / samplingRate;
			
			_duration = _remaining = TimeConversion.barsToNumSamples( noteEvent.duration, engine.bpm );
		}
		
		public function stop() : void
		{
			// not implemented
		}

		public function processAdd( current: Signal, numSignals: int ) : Boolean
		{
			var envelope: Number;
			var amplitude: Number;
			
			for( var i: int = 0 ; i < numSignals ; ++i )
			{
				if( _remaining )
				{
					envelope = ( --_remaining ) / _duration - 1.0;
					envelope = 1.0 - envelope * envelope;

					amplitude = WaveFunction.biSinus( _phase ) * envelope * volume;

					current.l += amplitude;
					current.r += amplitude;
					current = current.next;

					_phase += _phaseIncr;
					if( _phase >= 1.0 )
						_phase -= 1.0;
				}
				else
				{
					// COMPLETE
					return true;
				}
			}
			
			return false;
		}

		public function dispose() : void {}
	}
}
