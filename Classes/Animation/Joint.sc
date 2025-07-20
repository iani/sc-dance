//土 19  7 2025 20:33
// Hold all JointIO instances belonging to of a joint
// Useful for group operations such as sum of inputs,
// sum of input slopes, etc.

Joint {
	var <avatar, <name, <vars;

	*new { | avatar, name, vars |
		^this.newCopyArgs(avatar, name, vars);
	}

	sumIn {
		^Mix(vars collect: _.ain);
	}

	sumSlope {
		var inputs;
		inputs = vars collect: _.ain;
		inputs = inputs collect: { | i | Slope.kr(i.lag(1)).abs.lag(1) };
		^Mix(inputs);
	}

}