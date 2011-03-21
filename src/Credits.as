
/**		
 * 
 *	Credits
 *	
 *	@version 1.00 | Oct 8, 2010
 *	@author Justin Windle
 *  
 **/
 
package  
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.MouseEvent;
	import com.bit101.components.Label;
	import flash.display.Sprite;

	/**
	 * Credits
	 */
	public class Credits extends Sprite 
	{
		private static const TEXT : String = "Made with Tonfall";
		private var _label : Label = new Label();
		
		public function Credits()
		{
			_label.text = TEXT.toUpperCase();
			addChild(_label);
			
			addEventListener(MouseEvent.CLICK, onClicked);
			buttonMode = true;
		}

		private function onClicked(event : MouseEvent) : void 
		{
			navigateToURL(new URLRequest("http://code.google.com/p/tonfall/"), "_blank");
		}
	}
}
