
/**		
 * 
 *	Main
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package  
{
	import sequencer.Brain;

	import tonfall.display.AbstractApplication;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;

	/**
	 * Main
	 */

	[SWF(backgroundColor="#222222", frameRate="31", width="900", height="620")]

	public class Main extends AbstractApplication 
	{
		private var _brain : Brain;
		private var _gui : GUI;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function makeTexture() : BitmapData
		{
			var bmd : BitmapData = new BitmapData(2, 2, true, 0x0);
			bmd.setPixel32(0, 0, 0x33000000);
			return bmd;
		}

		private function onAddedToStage(event : Event) : void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.frameRate = 40;
			
			Config.WIDTH = stage.stageWidth;
			Config.HEIGHT = stage.stageHeight - GUI.HEIGHT;
			
			graphics.beginFill(0x222222);
			graphics.drawRect(0, 0, Config.WIDTH, Config.HEIGHT);
			graphics.endFill();
			
			_brain = new Brain();
			addChild(_brain);
			
			var tex : Shape = new Shape();
			tex.graphics.beginBitmapFill(makeTexture());
			tex.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			tex.graphics.endFill();
			addChild(tex);
			
			/*var inv : Shape = new Shape();
			inv.graphics.beginFill(0x000000);
			inv.graphics.drawRect(0, 0, Config.WIDTH, Config.HEIGHT);
			inv.graphics.endFill();
			inv.blendMode = BlendMode.INVERT;
			addChild(inv);*/
			
			_gui = new GUI(_brain);
			_gui.y = stage.stageHeight - GUI.HEIGHT;
			addChild(_gui);
		}
	}
}
