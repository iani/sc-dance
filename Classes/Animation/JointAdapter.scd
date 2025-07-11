//日  6  7 2025 23:05
//This adapter get obtains val from the corresponding synth control bus
// 金 11  7 2025 16:23 not yet used.

JointAdapter : ValueAdapter {
	var <>controls, <>index = 0;

	filter { | input |
		val = controls[index];
		^func.(input, val);
	}
}