
/**		
 * 
 *	sequencer.Brain
 *	
 *	@version 1.00 | Oct 5, 2010
 *	@author Justin Windle
 *  
 **/
 
package sequencer 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * Brain
	 */
	public class Brain extends Sprite 
	{
		private var _neurons : Vector.<Neuron> = new Vector.<Neuron>();
		private var _synapses : Vector.<Synapse> = new Vector.<Synapse>();
		private var _receptors : Vector.<Receptor> = new Vector.<Receptor>();
		private var _connections : Dictionary = new Dictionary();
		private var _voice : Voice = new Voice();

		private var _numNeurons : int = 0;		private var _numReceptors : int = 0;

		public function Brain()
		{
			numNeurons = Config.NUM_NEURONS;
			numReceptors = Config.NUM_RECEPTORS;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function update() : void
		{
			var i : int, j : int;
			var dx : Number, dy : Number, dSq : Number;
			var n : Neuron, r : Receptor, s : Synapse;
			
			var nc : int = _neurons.length;
			var rc : int = _receptors.length;
			
			for(i = 0;i < nc;++i)
			{
				n = _neurons[i];
				
				for(j = 0;j < rc;++j)
				{
					r = _receptors[j];
					
					dx = r.x - n.x;
					dy = r.y - n.y;
					dSq = dx * dx + dy * dy;
					
					if(dSq <= Config.MIN_PROXIMITY_SQ)
					{
						// connect
						if(!_connections[n][r])
						{
							s = new Synapse(n, r);
							addChildAt(s, 0);
							
							_connections[n][r] = s;
							_synapses.push(s);
						}
					}
					else
					{
						// disconnect
						if(_connections[n][r])
						{
							s = _connections[n][r];
							removeChild(s);
							
							delete _connections[n][r];
							_synapses.splice(_synapses.indexOf(s), 1);
							
							s.destroy();
							s = null;
						}
					}
				}
			}
			
			for(i = 0;i < _synapses.length;++i)
			{
				s = _synapses[i];
				
				if(s.input.parent && s.output.parent)
				{
					s.draw();
				}
				else
				{
					_synapses.splice(i, 1);
					removeChild(s);
					s.destroy();
					s = null;
				}
			}
			
			// render
			for(i = 0;i < _neurons.length;++i) _neurons[i].draw();			for(i = 0;i < _receptors.length;++i) _receptors[i].draw();
		}

		private function onEnterFrame(event : Event) : void 
		{
			update();
		}

		private function onNeuronFired(event : NodeEvent) : void 
		{
			var n : Neuron = event.target as Neuron;
			for each (var s : Synapse in _connections[n]) s.fire();
		}
		
		private function onReceptorPulse(event : NodeEvent) : void 
		{
			var r : Receptor = event.target as Receptor;
			_voice.queue(r.note + (event.data.octave * 19));
		}

		//	----------------------------------------------------------------
		//	MUTATORS
		//	----------------------------------------------------------------

		public function get numNeurons() : int
		{
			return _numNeurons;
		}

		public function set numNeurons(value : int) : void
		{
			var n : Neuron;
			
			if(_numNeurons < value)
			{
				while(_numNeurons < value)
				{
					n = new Neuron();
					n.addEventListener(NodeEvent.PULSE, onNeuronFired);
					addChild(n);
				
					_connections[n] = new Dictionary();
					_neurons.push(n);
				
					++_numNeurons;
				}
			}
			else if(_numNeurons > value)
			{
				while(_numNeurons > value)
				{
					n = _neurons.pop();
					n.removeEventListener(NodeEvent.PULSE, onNeuronFired);
					removeChild(n);
					
					_connections[n] = null;
					delete _connections[n];
					n.destroy();
					n = null;
					
					--_numNeurons;
				}
			}
		}

		public function get numReceptors() : int
		{
			return _numReceptors;
		}

		public function set numReceptors(value : int) : void
		{
			var r : Receptor;
			
			if(_numReceptors < value)
			{
				while(_numReceptors < value)
				{
					r = new Receptor();
					r.addEventListener(NodeEvent.PULSE, onReceptorPulse);
					addChild(r);
					
					_receptors.push(r);
					++_numReceptors;
				}
			}
			else if(_numReceptors > value)
			{
				while(_numReceptors > value)
				{
					r = _receptors.pop();
					r.removeEventListener(NodeEvent.PULSE, onReceptorPulse);
					removeChild(r);
					r.destroy();
					r = null;
					
					--_numReceptors;
				}
			}
		}
	}
}
