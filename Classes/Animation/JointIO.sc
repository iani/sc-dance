// 日 13  7 2025 19:41
// Shortcuts for io to AnimationController's buses

JointIO {
	var <avatar, <joint, <>msgBus, <>ctlBus;

	*new { | avatar, joint, msgBus, ctlBus |
		^this.newCopyArgs(avatar, joint, msgBus, ctlBus);
	}
	name { ^joint } // synonym
	in { ^this.controlIn }
	controlIn { ^In.kr(ctlBus) }

	controlOut { | ugens | ^this.out(ugens) }
	out { | ugens |
		^Out.kr(ctlBus, ugens) }

	rout { | ugens |
		^Out.kr(ctlBus, ugens)
	}

	ain { ^this.avatarIn }
	avatarIn { | lo, hi |
		var src;
		src = In.kr(msgBus);
		if (lo.notNil) {
			^src.linlin(-2, 2, lo, hi);
		}{
			^src
		}
	}

	// sum of joint variable values
	jsum { | joint |
		//		^
	}
	aout { | ugens | ^this.avatarOut(ugens) }
	avatarOut { | ugens | ^Out.kr(msgBus, ugens) }
}