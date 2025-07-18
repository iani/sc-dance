//: 木 17  7 2025 14:40
// Construct and return ControlName
+ Symbol {
	ctlName { | suffix = "", defaultVal = 0, lag |
		^(this ++ suffix).asSymbol.kr(defaultVal, lag);
	}

	jslope { | avatar = \default|
		^JointSlope(this, avatar);
	}
}