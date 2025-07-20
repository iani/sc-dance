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

	// 	from redux:		Amplitude.kr(Slope.kr(s.snum(id).sr)).lag(lag)
	slope { | lag = 0.5, ilag = 0.5 |
		var inputs;
		inputs = vars collect: _.ain;
		inputs = inputs collect: { | i |
			Amplitude.kr(Slope.kr(i.lag(ilag))).lag(lag); };
		^Mix(inputs);
	}

	slopePhrase {
		| lothresh = 2, hithresh = 3, map1 = 1000, map2 = 200,
		lag1 = 1.5, lag2 = 0.1, lag = 0.5, ilag = 0.5  |

		var inputs, slope, mappedSlope, slopePhrase;
		inputs = vars collect: _.ain;
		inputs = inputs collect: { | i |
			Amplitude.kr(Slope.kr(i.lag(ilag))).lag(lag); };
		slope = Mix(inputs);
		slopePhrase = (slope > lothresh).lag(lag1)
		* (slope < hithresh).lag(lag2) * slope;
		mappedSlope = slope.linlin(0, hithresh, map1, map2);
		^[slopePhrase, mappedSlope];
	}

}