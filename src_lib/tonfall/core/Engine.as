package tonfall.core
{
	import flash.utils.ByteArray;

	/**
	 * Engine runs the digital audio processing chain
	 * and writes the last SignalBuffer into a ByteArray.
	 * 
	 * It also stores the current time position in bars and beats per minutes.
	 * 
	 * @author Andre Michelle
	 */
	public final class Engine
	{
		public static function getInstance(): Engine
		{
			if( null == instance )
			{
				instance = new Engine();
			}

			return instance;
		}

		private static var instance: Engine = null;
		
		private const blockInfo: BlockInfo = new BlockInfo();
		
		private var _bar: Number; // BAR POSITION
		private var _bpm: Number; // BEATS PER MINUTE
		private var _processors: Vector.<Processor>; // LINEAR LIST OF PROCESSORS
		private var _input: SignalBuffer;

		public function Engine()
		{
			if( instance != null )
			{
				throw new Error( 'AudioEngine is Singleton.' );
			}

			_bar = 0.0;
			_bpm = 120.0;
			_processors = new Vector.<Processor>();
		}

		internal function render( target: ByteArray, numSignals: int ) : void
		{
			const to: Number = _bar + TimeConversion.numSamplesToBars( numSignals, _bpm );

			blockInfo.reset( numSignals, _bar, to );

			renderProcessors();
			
			_bar = to;
			
			if( null != _input )
			{
				writeInput( target, numSignals );
			}
		}

		private function renderProcessors() : void
		{
			var i: int = 0;
			var n: int = _processors.length;

			for( ; i < n ; ++i )
			{
				_processors[i].process( blockInfo );
			}
		}

		private function writeInput( target: ByteArray, num: int ) : void
		{
			var signal: Signal = _input.current;

			for( var i: int = 0 ; i < num ; ++i )
			{
				target.writeFloat( signal.l );
				target.writeFloat( signal.r );
				
				signal = signal.next;
			}
		}

		public function get bar() : Number
		{
			return _bar;
		}

		public function set bar( value: Number ) : void
		{
			_bar = value;
		}

		public function get bpm() : Number
		{
			return _bpm;
		}

		public function set bpm( value: Number ) : void
		{
			_bpm = value;
		}

		public function get processors() : Vector.<Processor>
		{
			return _processors;
		}

		public function set input( value: SignalBuffer ) : void
		{
			_input = value;
		}

		public function deltaBlockIndexAt( position: Number ) : int
		{
			const value: int = TimeConversion.barsToNumSamples( position - _bar, _bpm );

			if( value < 0 || value >= Driver.BLOCK_SIZE )
			{
				throw new Error( 'Index out of Block. index: ' + value );
			}
			
			return value;
		}
	}
}