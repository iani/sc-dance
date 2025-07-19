// 火  8  7 2025 18:55

// 1. Handle control synths writing to buses corresponding to joint
// variables. Poll these busses and cache their values for access
// by Animator.
// 2. Write animation values produced by Animator into another
//    multichannel bus
// 3. Handle synths reading from the animationvalues in the bus.

AnimationController {
	var <ctlbus, <ctlvalues;
	var <animbus;
	var <pollTask;
	var <ioArray, <ioEnvir;
	var <>avatar, <synths;

	init { | argAvatar |
		avatar = argAvatar;
		ctlvalues = List();
		synths = IdentityDictionary();
		this.addAdapter(avatar, \messageFormat, { | adapter, parser |
			this.reset(parser);
		})
	}

	reset { | parser |
		ctlvalues.array = { 0 } ! parser.ctlNames.size;
		ctlbus.free;
		animbus.free;
		this.makeBuses(parser);
	}

	makeBuses { | parser |
		ctlbus = Bus.control(Server.default, ctlvalues.size);
		animbus = Bus.control(Server.default, ctlvalues.size);
		this.makeIO(parser);
	}

	makeIO { | parser |
		var jointNames;
		ioArray = parser.ctlNames collect: { | n, i |
			JointIO(n, i + animbus.index, i + ctlbus.index);
		};
		ioEnvir = Event();
		ioArray do: { | j | ioEnvir[j.joint] = j; };
		ioEnvir[\all] = ioArray;
		jointNames = parser.jointNames;
		ioArray.clump(7) do: { | a, i | ioEnvir[jointNames[i]] = a; }
	}

	play {
		pollTask = Task({
			loop {
				ctlbus.getn(ctlbus.numChannels, { | values |
					ctlvalues.array = values;
					avatar.changed(\ctlValues, values);
					avatar.animator.filterAndPublish(
						avatar.animator.message;
					);
				});
				30.reciprocal.wait;
			}
		});
		pollTask.play;
		this.addAdapter(avatar, \rawValues, { | a ... vals |
			animbus.setn(vals);
		});
		CmdPeriod add: this;
	}
	stop {
		pollTask.stop;
		CmdPeriod remove: this;
	}
	doOnCmdPeriod { /* this.play */ /* MAYBE??? */ }

	// =========== SYNTHS and Control ============
	jointIO { | joint | ^ioEnvir[joint] }
	addSynth { | key, synthFunc |
		this.removeSynth(key);
		postf("Controller addSynth. ioEnvir: %\n", ioEnvir);
		avatar addSetFilter: key;
		synths[key] = ioEnvir use: {
			var thesynth;
			"doing synthfunc!".postln;
			thesynth = synthFunc.play;
			postf("The synth is: %\n", thesynth);
		};
	}

	removeSynth { | key |
		this.synths[key].free;
		synths[key] = nil;
		avatar removeFilter: key;
	}

	setctl { | key, value |
		ctlbus.setAt(avatar.ctloffset(key), value)
	}
}