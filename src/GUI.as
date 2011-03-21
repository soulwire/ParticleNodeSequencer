
/**		
 * 
 *	GUI
 *	
 *	@version 1.00 | Oct 6, 2010
 *	@author Justin Windle
 *  
 **/
 
package  
{
	import sequencer.Brain;

	import tonfall.display.Spectrum;

	import com.bit101.components.CheckBox;
	import com.bit101.components.HUISlider;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * GUI
	 * Set: -static-link-runtime-shared-libraries=true
	 */
	public class GUI extends Sprite 
	{
		public static const HEIGHT : int = 40;

		private var _brain : Brain;

		private var _neuronsSlider : HUISlider = new HUISlider();		private var _receptorsSlider : HUISlider = new HUISlider();		private var _proximitySlider : HUISlider = new HUISlider();
		private var _spectrumCB : CheckBox = new CheckBox();		private var _wanderCB : CheckBox = new CheckBox();
		private var _spectrum : Spectrum = new Spectrum();
		private var _credits : Credits = new Credits();

		public function GUI(__brain : Brain)
		{
			_brain = __brain;
			_spectrum.alpha = 0.9;
			
			var px : int = 10;
			var gap : int = 0;
			
			graphics.beginFill(0x222222);
			graphics.drawRect(0, 0, Config.WIDTH, HEIGHT);
			graphics.endFill();
			
			graphics.lineStyle(0, 0x444444);
			graphics.lineTo(Config.WIDTH, 0);
			
			_neuronsSlider.addEventListener(Event.CHANGE, onComponentChanged);
			_neuronsSlider.minimum = 0;
			_neuronsSlider.maximum = Config.MAX_NEURONS;
			_neuronsSlider.label = "Neurons:".toUpperCase();
			_neuronsSlider.value = Config.NUM_NEURONS;
			_neuronsSlider.x = px;
			_neuronsSlider.y = 10;
			addChild(_neuronsSlider);
			
			px += _neuronsSlider.width + gap;
			
			_receptorsSlider.addEventListener(Event.CHANGE, onComponentChanged);
			_receptorsSlider.minimum = 0;
			_receptorsSlider.maximum = Config.MAX_RECEPTORS;
			_receptorsSlider.label = "Receptors:".toUpperCase();
			_receptorsSlider.value = Config.NUM_RECEPTORS;
			_receptorsSlider.x = px;
			_receptorsSlider.y = 10;
			addChild(_receptorsSlider);
			
			px += _receptorsSlider.width + gap;
			
			_proximitySlider.addEventListener(Event.CHANGE, onComponentChanged);
			_proximitySlider.minimum = 0;
			_proximitySlider.maximum = 300;
			_proximitySlider.label = "Proximity:".toUpperCase();
			_proximitySlider.value = Config.MIN_PROXIMITY;
			_proximitySlider.x = px;
			_proximitySlider.y = 10;
			addChild(_proximitySlider);
			
			px += _proximitySlider.width + gap;
			
			_wanderCB.addEventListener(MouseEvent.CLICK, onComponentChanged);
			_wanderCB.label = "Wander".toUpperCase();
			_wanderCB.selected = true;
			_wanderCB.x = px;
			_wanderCB.y = 14;
			addChild(_wanderCB);
			
			px += 70;
			
			_spectrumCB.addEventListener(MouseEvent.CLICK, onComponentChanged);
			_spectrumCB.label = "Spectrum".toUpperCase();
			_spectrumCB.x = px;
			_spectrumCB.y = 14;
			addChild(_spectrumCB);
			
			_credits.x = Config.WIDTH - 110;
			_credits.y = 10;
			addChild(_credits);
		}

		private function onComponentChanged(event : Event) : void 
		{
			switch(event.currentTarget)
			{
				case _neuronsSlider : 
					_brain.numNeurons = _neuronsSlider.value;
					break;
					
				case _receptorsSlider : 
					_brain.numReceptors = _receptorsSlider.value;
					break;
					
				case _proximitySlider : 
					Config.MIN_PROXIMITY = _proximitySlider.value;					Config.MIN_PROXIMITY_SQ = Config.MIN_PROXIMITY * Config.MIN_PROXIMITY;
					break;
					
				case _spectrumCB :
					
					if(_spectrumCB.selected)
					{
						_spectrum.x = 0;
						_spectrum.y = -100;
						_spectrum.width = Config.WIDTH;
						_spectrum.height = 100;
						addChild(_spectrum);
					}
					else
					{
						removeChild(_spectrum);
					}
					
					break;
					
				case _wanderCB :
					Config.WANDER = _wanderCB.selected;
					break;
			}
		}
	}
}
