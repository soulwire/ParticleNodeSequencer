
/**		
 * 
 *	math.random
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package math 
{

	public function random(min : Number, max : Number = NaN) : Number
	{
		if(isNaN(max))
		{
			max = min;
			min = 0;
		}
		
		return min + (Math.random() * (max - min));
	}
}
