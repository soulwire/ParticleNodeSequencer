package tonfall.core
{
	/**
	 * Processor is a member in the digital audio processing chain.
	 * 
	 * A Processor can generate audio or sequence events.
	 * 
	 * @author Andre Michelle
	 */
	public /*abstract*/ class Processor
	{
		protected const events: Vector.<TimeEvent> = new Vector.<TimeEvent>();
		
		protected const engine: Engine = Engine.getInstance();
		
		public function Processor() {}
		
		public function addTimeEvent( event: TimeEvent ): void
		{
			if( -1 < events.indexOf( event ) )
			{
				throw new Error( 'Element already exists.' );
			}

			events.push( event );
			events.sort( sortOnPosition );
		}

		public function process( info: BlockInfo ): void
		{
			throw new Error( 'Method "process" is marked abstract.' );
		}
		
		private function sortOnPosition( a: TimeEvent, b: TimeEvent ): int
		{
			if( a.position > b.position )
				return 1;
			if( a.position < b.position )
				return -1;

			return 0;
		}
	}
}