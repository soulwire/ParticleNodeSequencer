Particle Sequencer
==================

Demo
----

Full information and a demonstration of the sequencer can be found [here](http://blog.soulwire.co.uk/laboratory/flash/as3-tonfall-particle-node-sequencer)

About
-----

This sequencer is based around physical nodes, which connect to produce a variety of tones. There are two types of node, a neuron and a receptor, which are connected by synapses (apologies for the trite analogies). Neurons fire periodically, and if within a certain proximity of a receptor, this message is sent at a fixed speed along the bridging synapse. When the message arrives, the receptor is activated and responds by queuing it's individual tone within the audio engine. Each receptor owns a randomly assigned note, and each neuron a randomly assigned octave; therefor a receptor will play it's note in several different octaves depending on which neuron causes it to fire.

The download includes the builds of [Tonfall](http://code.google.com/p/tonfall/) by [Andre Michelle](http://www.andre-michelle.com/) and [Minimal Comps](http://blog.soulwire.co.uk/goto/http://www.minimalcomps.com/) by [Keith Peters](http://www.bit-101.com/blog/) that I'm using.