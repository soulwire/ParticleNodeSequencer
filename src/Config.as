
/**		
 * 
 *	Config
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package  
{

	/**
	 * Config
	 */
	public class Config 
	{
		public static const NUM_NEURONS : int = 4;		public static const MAX_NEURONS : int = 5;
		
		public static const NUM_RECEPTORS : int = 16;		public static const MAX_RECEPTORS : int = 24;
		
		public static const COLOURS : Array = [0xb1d25d, 0xe15249, 0x8cd9b2, 0x008a8e, 0xa6ad8f, 0x00ddd5, 0xff7659, 0xf9fb41, 0x41dafb, 0xd879ff];
		
		public static var MIN_PROXIMITY : int = 160;		public static var MIN_PROXIMITY_SQ : int = MIN_PROXIMITY * MIN_PROXIMITY;
		
		public static var WIDTH : int = 100;		public static var HEIGHT : int = 100;
		public static var WANDER : Boolean = true;
	}
}
