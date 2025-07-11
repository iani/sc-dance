// 金 11  7 2025 05:36
// Parse messags received from Rokoko.
// Hold dictionaries that translate symbol addresses of joints
// to index addresses in a Rokoko message or in a control bus
// holding rokoko data.

RokokoParser {
	classvar <vars = #["", \x, \y, \z, \qx, \qy, \qz, \qw];
	var <>avatar; // notify avatar when format changes;
	var <message;
	var <symbols, <indices;
	var <msgNames, <busNames;
	var <msgDict; // translate from joint name to index in rokoko message
	var <busDict; // translate from joint name to index in bus/data array

	*new { | avatar |
		^this.newCopyArgs(avatar);
	}

	parse { | argMessage |
		var i;
		message = argMessage;
		symbols = message.select({|x| x isKindOf: Symbol });
		i = symbols collect: { | s | message indexOf: s  };
		// postf("Parser % comparing indices\n", this);
		// postf("Newly created indices are: %\n", i);
		// postf("Already existing indices are: %\n", indices);
		// postf("Comparing them. Are they equal? : %\n", indices == i);
		// postf("Comparing them. Are they NOT equal? : %\n", indices != i);
		if (i != indices) {
			"Message format has changed. Updating!".postln;
			indices = i;
			this.makeDicts;
			avatar.changed(\messageFormat, this);
		};
	}

	makeDicts {
		var jointNames, offset;
		offset = symbols indexOf: \hip;
		jointNames = symbols[offset..];
		msgNames = this.makeMessageNames(jointNames);
		// postf("msg names %\n", msgNames);
		busNames = this.makeBusNames(jointNames);
		// postf("bus names %\n", busNames);
		msgDict = IdentityDictionary();
		msgNames do: { | n, i | msgDict[n] = i + offset; };
		busDict = IdentityDictionary();
		busNames do: { | n, i | busDict[n] = i; };
	}

	makeMessageNames { | jn |
		^jn.collect({ | j |
			vars collect: { | v | (j ++ v).asSymbol };
		}).flat
	}

	makeBusNames { | jn |
		var busVars;
		busVars = vars[1..];
		^jn.collect({ | j |
			busVars collect: { | v | (j ++ v).asSymbol };
		}).flat
	}
	/*
	makeMessageJoints {

		var hip, jointNames, jointVarNames;
		hip = message indexOf: \hip;
		jointNames = symbols[(symbols indexOf: \hip)..];
		postf("Joint names are: %\n", jointNames);
		jointNames collect: { | n |
			vars do: { | v |
				jointPairs = jointPairs add: format("%%", n, v).asSymbol;
			}
		};
		busVars = vars[1..];

		postf("joint pairs are: %\n", jointPairs);
		msgDict = IdentityDictionary();
		jointPairs do: {  }
	}
	*/
	makeMessageDict {
		var messageJoints;
	}

	makeBusDict {

	}
}