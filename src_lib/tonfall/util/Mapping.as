package tonfall.util
{
	/**
	 * @author aM
	 */
	public final class Mapping
	{
		public function mapLinear( normalized:Number, min: Number, max: Number ): Number
		{
			return min + normalized * ( max - min );
		}

		public function mapExp( normalized:Number, min: Number, max: Number ):Number
		{
			return min * Math.exp( normalized * Math.log( max / min ) );
		}
	}
}