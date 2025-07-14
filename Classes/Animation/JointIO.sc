// 日 13  7 2025 19:41
// Shortcuts for io to AnimationController's buses

JointIO {
	var <joint, <>msgBus, <>ctlBus;

	*new { | joint, msgBus, ctlBus |
		^this.newCopyArgs(joint, msgBus, ctlBus);
	}

	in { ^this.controlIn }
	controlIn { ^In.kr(ctlBus) }

	controlOut { | ugens | ^this.out(ugens) }
	out { | ugens | ^Out.kr(ctlBus, ugens) }

	rin { ^this.avatarIn }
	avatarIn { ^In.kr(msgBus) }
	rout { | ugens | ^this.avatarOut(ugens) }
	avatarOut { | ugens | ^Out.kr(msgBus, ugens) }
}