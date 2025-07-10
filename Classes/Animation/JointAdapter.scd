//日  6  7 2025 23:05
//This adapter get obtains val from the corresponding synth control bus

JointAdapter : ValueAdapter {
	var <joint, <>ctlArray;

	filter { | input |
		val = ctlArray[joint.busIndex];
		^func.(input, val);
	}
}