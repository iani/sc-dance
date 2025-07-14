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
	var <ctlPollRoutine;
	var <ioArray, <ioEnvir;
	var <>avatar, synths;

	init { | argAvatar |
		avatar = argAvatar;
		ctlvalues = List();
		// this.reset(avatar.parser);
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
		ioArray = parser.ctlNames collect: { | n, i |
			JointIO(n, i + animbus.index, i + ctlbus.index);
		};
		ioEnvir = Event();
		ioArray do: { | j | ioEnvir[j.joint] = j; }
	}

	play {
		ctlPollRoutine = fork {
			loop {
				ctlbus.getn(ctlbus.numChannels, { | values |
					ctlvalues.array = values;
					avatar.changed(\ctlvalues, values);
				});
				30.reciprocal.wait;
			}
		};
		this.addAdapter(avatar, \rawvalues, { | a ... vals |
			animbus.setn(vals);
		});
		CmdPeriod add: this;
	}
	stop {
		ctlPollRoutine.stop;
		CmdPeriod remove: this;
	}
	doOnCmdPeriod { /* this.play */ /* MAYBE??? */ }

	// =========== SYNTHS ============

	addSynth { | key, synthFunc |
		this.deleteSynth(key);
		synths[key] = ioEnvir use: { synthFunc.play; };
	}

	synths { ^synths ?? { synths = IdentityDictionary(); } }

	deleteSynth { | key |
		this.synths[key].free;
		synths[key] = nil;
	}
}