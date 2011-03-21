package tonfall.core
{
	/**
	 * SignalProcessor provides sample-exact event processing.
	 * 
	 * @author Andre Michelle
	 */
	public /*abstract*/ class SignalProcessor extends Processor
	{
		public function SignalProcessor() {}

		final override public function process( info: BlockInfo ) : void
		{
			var event: TimeEvent;
			
			var localOffset:int = 0;

			var numSignals: int = info.numSignals;

			var eventOffset: int;

			while( events.length ) // IF INPUT EVENTS EXISTS
			{
				event = events.shift();

				eventOffset = engine.deltaBlockIndexAt( event.position ) - localOffset;
				
				if( 0 < eventOffset )
				{
					// ADVANCE IN BUFFER
					processSignals( eventOffset );

					numSignals -= eventOffset;
					localOffset += eventOffset;
				}
				
				// SEND EVENT ON THE EXACT POSITION
				processTimeEvent( event );
				
				event.dispose();
			}

			if( numSignals )
			{
				// PROCESS REST
				processSignals( numSignals );
			}
		}
		
		protected function processTimeEvent( event: TimeEvent ): void
		{
			throw new Error( 'Method "processTimeEvent" is marked abstract.' );
		}
		
		protected function processSignals( numSignals: int ): void
		{
			throw new Error( 'Method "processSignals" is marked abstract.' );
		}
	}
}