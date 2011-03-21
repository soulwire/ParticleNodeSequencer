package test
{
	import tonfall.core.BlockInfo;
	import tonfall.core.Processor;
	import tonfall.core.Signal;
	import tonfall.core.SignalBuffer;

	/**
	 * Hello World in DSP
	 * 
	 * @author Andre Michelle
	 */
	public final class ContinuousSinusProcessor extends Processor
	{
		public const output: SignalBuffer = new SignalBuffer();
	
		private var _frequency: Number;
		private var _phase: Number;

		public function ContinuousSinusProcessor( frequency: Number = 220.0 )
		{
			_frequency = frequency;
			_phase = 0.0;
		}

		override public function process( info: BlockInfo ) : void
		{
			var signal: Signal = output.current;
	
			var i: int = 0;
			var n: int = info.numSignals;
			
			for( ; i < n ; ++i )
			{
				signal.l = signal.r = Math.sin( _phase * 2.0 * Math.PI );
	
				_phase += _frequency / 44100.0;
	
				signal = signal.next;
			}
	
			output.advancePointer( info.numSignals );
		}
	}
}
