//:木 17  7 2025 14:29
// kr: Return sum of slopes of all variables in a Joint.
// trig: Return a trigger each time that the slope sum
// exceeds a threshold.

JointSlope {
	var <joint, <avatar, <jointio, <ctl;

	*new { | joint, avatar |
		^this.newCopyArgs(joint, avatar).init;
	}

	init {
		avatar ?? { avatar = Avatar.default.name };
		avatar = Avatar(avatar);
		jointio = Avatar jointIO: joint;
		ctl = jointio.in;
	}

	kr { | joint |

	}

	trig {

	}
}