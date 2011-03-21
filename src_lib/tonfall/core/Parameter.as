package tonfall.core
{
	/**
	 * Parameter stores a normalized value for external controlling
	 * 
	 * @author aM
	 */
	public final class Parameter
	{
		private var _name : String;
		private var _value : Number;

		public function Parameter( name : String, value : Number = 0.0 )
		{
			_name = name;
			_value = value;
		}

		public function get name() : String
		{
			return _name;
		}

		public function get value() : Number
		{
			return _value;
		}

		public function set value( value : Number ) : void
		{
			_value = value;
		}
	}
}
