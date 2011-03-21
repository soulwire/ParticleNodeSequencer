package tonfall.core
{
	/**
	 * TimeConversion provides conversion between absolute and musical time.
	 * 
	 * One bar is based on 4/4 time signature.
	 * 
	 * @author Andre Michelle
	 */
	public final class TimeConversion
	{
		public static function barsToMillis( bars:Number, bpm: Number ):Number
		{
			return ( bars * 240.0 / bpm ) * 1000.0;
		}
		
		public static function barsToNumSamples( bars:Number, bpm: Number ):Number
		{
			return ( bars * 240.0 / bpm ) * samplingRate;
		}
		
		public static function millisToBars( millis:Number, bpm: Number ):Number
		{
			return ( millis * bpm / 240.0 ) / 1000.0;
		}
		
		public static function numSamplesToBars( numSamples: Number, bpm: Number ):Number
		{
			return ( numSamples * bpm / 240.0 ) / samplingRate;
		}
	}
}