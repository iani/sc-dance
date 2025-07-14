// 日 13  7 2025 19:41
// Shortcuts for io to AnimationController's buses

JointIO {
	var <joint, <>msgBus, <>ctlBus;

	*new { | joint, msgBus, ctlBus |
		^this.newCopyArgs(joint, msgBus, ctlBus);
	}

	in { ^In.kr(ctlBus) }
	rin { ^In.kr(msgBus) }
	out { | ugens | ^Out.kr(ctlBus, ugens) }
	rout { | ugens | ^Out.kr(msgBus, ugens) }
}