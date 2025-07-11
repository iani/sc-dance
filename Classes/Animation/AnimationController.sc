// 火  8  7 2025 18:55

// 1. Handle control synths writing to buses corresponding to joint
// variables. Poll these busses and cache their values for access
// by Animator.
// 2. Write animation values produced by Animator into another
//    multichannel bus
// 3. Handle synths reading from the animationvalues in the bus.

AnimationController {
	var <ctlbus, <ctlsynths, <ctlvalues;
	var <animbus, <animsynths;
	var <ctlPollRoutine;

	init { | avatar |
		this.addAdapter(avatar, \messageFormat, { | adapter, parser|
			postf("% received a messageFormat change with parser: %\n",
				this, parser);
			postf("as an AnimationController I will work with:\n");
			postf("joint names\n%\n", parser.msgNames);
			postf("and bus names\n%\n", parser.busNames);
		})
	}

	play {
		"AnimatorController:play is not yet implemented.".postln;
	}
}