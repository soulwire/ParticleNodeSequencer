package tonfall.core
{
	/**
	 * TimeEvent is the base class of all type of events while audio processing
	 * 
	 * @author Andre Michelle
	 */
	public class TimeEvent
	{
		public var position: Number; // in bars

		public function dispose() : void {}
	}
}