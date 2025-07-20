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
		loLag = 1.5, hiLag = 0.1, slopeLag = 0.5, ampLag = 0.5  |

		var inputs, slope, mappedSlope, slopePhrase;
		var lothreshCtl, hithreshCtl, map1Ctl, map2Ctl, loLagCtl, hiLagCtl, slopeLagCtl, ampLagCtl;

		lothreshCtl = \lothresh.kr(lothresh);
		hithreshCtl = \hithresh.kr(hithresh);
		map1Ctl = \map1.kr(map1);
		map2Ctl = \map2.kr(map2);
		loLagCtl = \loLag.kr(loLag);
		hiLagCtl = \hiLag.kr(hiLag);
		slopeLagCtl = \slopeLag.kr(slopeLag);
		ampLagCtl = \ampLag.kr(ampLag);

		inputs = vars collect: _.ain;
		inputs = inputs collect: { | i |
			Amplitude.kr(Slope.kr(i.lag(slopeLagCtl))).lag(ampLagCtl); };
		slope = Mix(inputs);
		slopePhrase = (slope > lothreshCtl).lag(loLagCtl)
		* (slope < hithreshCtl).lag(hiLagCtl) * slope;
		mappedSlope = slope.linlin(0, hithreshCtl, map1Ctl, map2Ctl);
		^[slopePhrase, mappedSlope];
	}

}