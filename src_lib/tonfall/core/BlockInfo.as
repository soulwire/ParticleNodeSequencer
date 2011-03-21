package tonfall.core
{
	/**
	 * BlockInfo describes all time information to process an audio block
	 * 
	 * @author Andre Michelle
	 */
	public final class BlockInfo
	{
		private var _numSignals: int;

		// Following values in musical time (bars)
		private var _from: Number;
		private var _to: Number;
		
		internal function reset( numSignals: int, from: Number, to: Number ): void
		{
			_numSignals = numSignals;
			_from = from;
			_to = to;
		}

		public function get numSignals() : int
		{
			return _numSignals;
		}

		public function get from() : Number
		{
			return _from;
		}

		public function get to() : Number
		{
			return _to;
		}
		
		public function toString(): String
		{
			return '[BlockInfo numSignals: ' + _numSignals + ', from: ' + _from.toFixed(3) + ', to: ' + _to.toFixed(3) + ']';
		}
	}
}