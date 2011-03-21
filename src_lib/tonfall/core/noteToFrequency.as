package tonfall.core
{
	/**
	 * Standard note <> frequency mapping
	 * 
	 * @author Andre Michelle
	 */
	public function noteToFrequency( note: int = 60.0 ) : Number
	{
		return 440.0 * Math.pow( 2.0, ( note + 3.0 ) / 12.0 - 6.0 );
	}
}