//: 土  5  7 2025 14:54
//: Handle the animation for a single named Avatar figure:
//- Load recorded session data
//- Send OSC messages, using the name of the avatar as
// 3d argument of the ['/rokoko' ... ] message array. Example:
// An avatar named \girl1 would send the message like this:
// ['/rokoko', <timestamp>, 'girl1', 'hip' ...]
// - Handle forwarding of data received live from Rokoko MOCAP
// - Create players to playback data from stored mocap sessions

// vars:
// sessiondata: a SessionData
// animator: an Animator
// controller: an AnimationController
// See implementation notes

Avatar : NamedInstance {
	classvar >localGodotAddr;
	var <>sessionPath;
	var <sessionData, <animator, <controller;
	var <oscAddress = '/rokoko/'; // address for remote respnse

	*localGodotAddr {
		^localGodotAddr ?? { localGodotAddr = NetAddr("127.0.0.1", 22245); }
	}
	*sessionGui { RokokoSessionsBookmark.sessionGui }

	*allSessionNames { // list sessions from all subclasses
		^RokokoSessionsBookmark.allSessionNames;
	}
	addLocalGodot {
		this.addReceiver(this.class.localGodotAddr);
	}

	deleteLocalGodot {
		this.deleteRaceiver(this.class.localGodotAddr);
	}

	addLocalSC {
		this.addReceiver(NetAddr.localAddr);
	}

	deleteLocalSC {
		this.deleteRaceiver(NetAddr.localAddr);
	}

	init { | argSessionPath |
		"initing avatar".postln;
		// this.simpleTrace;
		if(name === \default) {
			// "debug osc user local user id".postln;
				name = OscUser.localUserId;
		};
		sessionData = SessionData(argSessionPath, this);
		animator = Animator(this);
		controller = AnimationController().init(this);
		this.load(argSessionPath ?? { ScDanceAssets.defaultPath });
	}

	// filter and relay messages received via OSC
	enableRemote { | argOscAddress = '/rokoko/' |
		oscAddress = argOscAddress;
		this.stop; // stop playback from data;
		this.removeSynths;
		sessionData calibrateRemote: oscAddress;
	}

	disableRemote {
		this.removeAdapter(OscControl, oscAddress);
	}

	*start { this.default.start }
	*play { this.default.play }
	start { this.play } // Synonym. Implamenttation may change in the future
	play {
		if (sessionData.isNil) {
			^postf("% cannot play without data. Load a session.\n", this);
		};
		if (this.isPlaying) {
			^postf("% is already playing. Will not restart.\n", this);
		};
		this.reset;
		animator.play;
		controller.play;
	}

	*isPlaying { ^this.default.isPlaying }
	isPlaying { ^controller.pollTask.isPlaying }

	*stop { this.default.stop }
	stop {
		animator.stop;
		controller.stop;
	}

	*pause { this.default.pause }
	pause { animator.pause }
	*resume { this.default.resume }
	resume { animator.resume }
	*reset { this.default.reset }
	reset {
		this.removeSynths;
		this.removeFilters;
		animator.reset;
	}
	loadNamed { | sessionName |
		this load: AvatarAssets.sessionNamed(sessionName);
	}

	loadDialog {
		FileDialog({ | paths |
			var path;
			path = paths.first +/+ "";
			"Loading:".postln;
			path.postln;
			this.load(path);
		}, fileMode: 2);
	}
	load { | path |
		var messages;
		path ?? { path = ScDanceAssets.defaultPath };
		sessionPath = path;
		this.stop;
		postf("Loading session data from\n%\ninto %\n",
			path, this
		);
		sessionData load: sessionPath;
		messages = sessionData.messages;
			postf("\Loaded % messages\n", messages.size;
		);
		animator.message = messages.first;
		animator.messages = messages.pseq;
	}

	// for initializing / resetting?
	msgStream {} // ???
	timeStream {} // ???

	//----- adding/removing OSC receivers-----
	addReceiver { | netAddr | // asSymbol: guarante matching
		// IMPORTANT: if netAddr is local addr, then replace
		// '/rokoko/' osc message with '/r' in order to avoid
		// feedback when operating in filter-forward mode
		if (netAddr == NetAddr.localAddr) {
			netAddr.asSymbol.addAdapter(this, \msg, { | a ... msg |
				msg[0] = '/r';
				netAddr.sendMsg(*msg);
			});
			netAddr.asSymbol.addAdapter(this, \props, { | a ... msg |
				msg[0] = '/p';
				netAddr.sendMsg(*msg);
			});
		}{
			netAddr.asSymbol.addAdapter(this, \msg, { | a ... msg |
				netAddr.sendMsg(*msg);
			});
			netAddr.asSymbol.addAdapter(this, \props, { | a ... msg |
				netAddr.sendMsg(*msg);
			});
		}
	}
	deleteReceiver { | netAddr |
		// TODO: remove adapter '/r', '/p' for localAddr
		netAddr.asSymbol.removeAdapter(this, \msg);
		netAddr.asSymbol.removeAdapter(this, \props);
	}

	sendToSelf { | flag = true |
		if (flag) {
			this addReceiver: NetAddr.localAddr;
		}{
			this deleteReceiver: NetAddr.localAddr;
		}
	}

	sendToGodot { | flag = true |
		if (flag) {
			this addReceiver: this.localGodot;
		}{
			this deleteReceiver: this.localGodot;
		}
	}

	localGodot { ^this.class.localGodotAddr }

	//----- Props -----
	props { ^animator.props }
	setColor { | argr, argg, argb | animator.props.setColor(argr, argg, argb) }
	setType { | argType | animator.props.setType(argType) }
	setPos { | argx, argy, argz | animator.props.setPos(argx, argy, argz) }
	setRot { | argqx, argqy, argqz, argqw |
		animator.props.setRot(argqx, argqy, argqz, argqw);
	}

	setPosRot { | argx, argy, argz, argqx, argqy, argqz, argqw |
		animator.props.setPosRot(argx, argy, argz, argqx, argqy, argqz, argqw);
	}

	//----- joint and control access -----
	ctlNames { ^this.parser.ctlNames }
	jointNames { ^this.parser.jointNames }
	jointIO { | joint | ^controller.jointIO(joint) }
	ioEnvir { ^this.controller.ioEnvir }
	filter { ^animator.filter }
	// Basic filter methods
	addFilter { | jointName, func | animator.addFilter(jointName, func); }
	getFilter { | joint | ^animator getFilter: joint }
	removeFilter { | joint | animator removeFilter: joint }
	removeFilters { | ... names | animator.removeFilters(names) }
	// Function filter shortcuts
	addSetFilter { | jointName | this.addFilter(jointName, { | m, c | c }) }
	addAddFilter { | jointName | this.addFilter(jointName, { | m, c | m + c }) }
	addMulFilter { | jointName | this.addFilter(jointName, { | m, c | m * c }) }

	// Synth filter methods
	addSynth { | jointName, func |
		controller.addSynth(jointName, func);
	}
	// Shortcuts:
	// Better name: putClt. Other variants: addSumCtl, addMulCtl
	putClt { | jointName, func |
		this addSetFilter: jointName;
		controller.synths[jointName].free;
		controller.synths[jointName] = {
			controller.ioEnvir[jointName].rout(func.value)
		}.play;
	}
	// dangerous synonym?
	removeCtl { | jointName | this removeSynth: jointName }

	ctlvalues { ^controller.ctlvalues }
	ctlIndex { | joint | ^this.parser.ctlIndex(joint) }
	messages { ^sessionData.messages }
	messageSize { ^sessionData.messages.first.size }
	parser { ^sessionData.parser }

	filterMessage { | message |
		animator filterMessage: message;
	}

	publishValueArray { | publishMsg, argMsg |
		// get numeric values from raw rokoko message
		// and publish them with changed \values
		this.changed(publishMsg, sessionData.makeValueArray(argMsg))
	}

	// =========== SYNTHS + Control (of controlbus) ============

	// addSynth { | key, synthFunc | controller.addSynth(key, synthFunc) }
	removeSynths { | ... keys |
		var synths;
		synths = controller.synths;
		if (keys.size == 0) { keys = synths.keys.asArray };
		keys do: { | key | this removeSynth: key };
	}
	removeSynth { | key | controller.removeSynth(key) }

	setSynthCtl { | jointName, ctlName, value |
		var synth = controller.synths[jointName];
		if (synth.isNil) {
			postf("Avatar-setSynthCtl: No synth found for joint '%'", jointName);
		} {
			synth.set(ctlName, value);
		};
	}

	setctl { | key, value | controller.setctl(key, value); }
	ctloffset { | key | ^this.parser.ctlDict[key] }

	// =========== GUI ============
	valuesGui {
		// postf("VALUES GUI FOR %\n", this);
		Windows.makeWindow(this, \valuesGui, { | w |
			var rawview, filtview;
			w.name = format("Values played by %", this);
			w.bounds = Rect(0, 0, 1300, 200);
			w.layout = HLayout(
				~rawview = rawview = MultiSliderView(),
				~filtview = filtview = MultiSliderView()
			);
			rawview.thumbSize = 3;
			filtview.thumbSize = 3;
			rawview.addAdapter(this, \rawValues, { | a ... values |
				{
					a.listener.value = ([-2.0, 2.0] ++ values).normalize[2..];
				}.defer;
			});
			rawview.onClose = { | me |
				me.removeAdapter(this, \rawValues);
			};
			filtview.addAdapter(this, \ctlValues, { | a ... values |
				{
					a.listener.value = ([-2.0, 2.0] ++ values).normalize[2..];
				}.defer;
			});
			filtview.onClose = { | me |
				me.removeAdapter(this, \ctlValues);
			};
			w.front;
		})
	}
}