// 火  8  7 2025 18:55

// 1. Handle control synths writing to buses corresponding to joint
// variables. Poll these busses and cache their values for access
// by Animator.
// 2. Write animation values produced by Animator into another
//    multichannel bus
// 3. Handle synths reading from the animationvalues in the bus.

AnimationController {
	var <ctlbus, <ctlsynths, <ctlvalues;
	var <ctlPollRoutine;
	var <animbus, <animsynths;

}