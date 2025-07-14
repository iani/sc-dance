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
	var <msgNames, <ctlNames;
	var <msgDict; // translate from joint name to index in rokoko message
	var <ctlDict; // translate from joint name to index in bus/data array
	var <jointOffset; // index of first joint
	var <>firstJoint = \hip; // first joint in the msg array

	*new { | avatar |
		^this.newCopyArgs(avatar);
	}

	parse { | argMessage |
		var i, newSymbols;
		message = argMessage;
		newSymbols = message.select({|x| x isKindOf: Symbol });
		i = newSymbols collect: { | s | message indexOf: s };
		if ((i != indices) or: { newSymbols != symbols }) {
			"Message format has changed. Updating!".postln;
			indices = i;
			symbols = newSymbols;
			this.makeDicts;
			avatar.changed(\messageFormat, this);
		};
	}

	makeDicts {
		var jointNames;
		jointNames = symbols[symbols indexOf: firstJoint..];
		// postf("\n\n\n%\n\n\n", jointNames);
		jointOffset = message indexOf: firstJoint;
		// message[jointOffset..].postln;
		msgNames = this.makeMessageNames(jointNames);
		ctlNames = this.makeBusNames(jointNames);
		// postf("\n\n\nmsgNames:%\n\n\n", msgNames);
		// postf("\n\n\nctlNames:%\n\n\n", ctlNames);
		msgDict = IdentityDictionary();
		msgNames do: { | n, i | msgDict[n] = i + jointOffset; };
		ctlDict = IdentityDictionary();
		ctlNames do: { | n, i | ctlDict[n] = i; };
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

	msgIndex { | joint | ^msgDict[joint] }
	ctlIndex { | joint | ^ctlDict[joint] }

	makeValueArray { | argMsg |
		// since flop is not a primitive, this could be more expensive!
		// ^argMsg[jointOffset..].clump(8).flop[1..].flop.flat;
		^argMsg[jointOffset..] select: { | n | n.isKindOf(Symbol).not }
	}

	// for checking dicts:
	getJointValue { | joint |
		// postf("joint: %, message size: %\n\n", joint, message.size);
		// postt("msgIndex %\n", this.msgIndex[joint])
		^message[this.msgIndex(joint)];
	}

	postMsgDict {
		msgNames.postln;
		msgNames do: { | n | [n, msgDict[n]].postln; };
		msgNames.postln;
	}

	postCtlDict {
		ctlNames.postln;
		ctlNames do: { | n | [n, ctlDict[n]].postln; };
		ctlNames.postln;

	}
}