package test.poly
{
	import tonfall.core.TimeEventNote;
	import tonfall.poly.IPolySynthVoice;
	import tonfall.poly.IPolySynthVoiceFactory;

	/**
	 * Test implementation for a polyphonic synthesizer voice
	 * 
	 * @author Andre Michelle
	 */
	public final class SimplePolySynthVoiceFactory
		implements IPolySynthVoiceFactory
	{
		public static const INSTANCE : SimplePolySynthVoiceFactory = new SimplePolySynthVoiceFactory();

		public function create( event : TimeEventNote ) : IPolySynthVoice
		{
			return new SimplePolySynthVoice();
		}
	}
}
