package test.metronome
{
	import tonfall.core.TimeEvent;

	/**
	 * @author Andre Michelle
	 */
	public final class MetronomeEvent extends TimeEvent
	{
		public var bar: int;
	
		public var beat: int;
		
		public function toString(): String
		{
			return '[MetronomeEvent position: ' + position + ', bar: ' + bar + ', beat: ' + beat + ']';
		}
	}
}
