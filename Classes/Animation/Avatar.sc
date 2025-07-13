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

	*localGodotAddr {
		^localGodotAddr ?? { localGodotAddr = NetAddr("127.0.0.1", 22245); }
	}
	*sessionGui { RokokoSessionsBookmark.sessionGui }

	*allSessionNames { // list sessions from all subclasses
		^RokokoSessionsBookmark.allSessionNames;
	}
	addLocalGodot {
		this.addRaceiver(this.class.localGodotAddr);
	}

	deleteLocalGodot {
		this.deleteRaceiver(this.class.localGodotAddr);
	}

	addLocalSC {
		this.addRaceiver(NetAddr.localAddr);
	}

	deleteLocalSC {
		this.deleteRaceiver(NetAddr.localAddr);
	}

	init { | argSessionPath |
		// this.simpleTrace;
		sessionData = SessionData(argSessionPath, this);
		animator = Animator(this);
		controller = AnimationController().init(this);
		this.load(argSessionPath ?? { ScDanceSessions.defaultPath });
	}

	*play { this.default.start }
	*start { this.default.start }
	*stop { this.default.stop }
	*pause { this.default.pause }
	*resume { this.default.resume }
	*reset { this.default.reset }

	start { this.play }
	play {
		if (sessionData.isNil) {
			^"Cannot play without data. Load a session.".postln;
		};
		animator.play;
		controller.play;
	}

	stop {
		animator.stop;
		controller.stop;
	}

	loadNamed { | sessionName |
		this load: RokokoSessionsBookmark.allSessionsDict[sessionName]
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
		path ?? { path = ScDanceSessions.defaultPath };
		sessionPath = path;
		this.stop;
		postf("Loading session data from\n%\ninto %\n",
			path, this
		);
		sessionData load: sessionPath;
		messages = sessionData.messages;
			postf("\Loaded % messages\n", messages.size;
		);
		animator.messages = messages.pseq;
	}

	msgStream {}
	timeStream {}


	//----- adding/removing OSC receivers-----
	addReceiver { | netAddr | // asSymbol: guarante matching
		// IMPORTANT: if netAddr is local addr, then replace
		// '/rokoko/' osc message with '/r' in order to avoid
		// feedback when operating in filter-forward mode
		if (netAddr == NetAddr.localAddr) {
			netAddr.asSymbol.addAdapter(this, \msg, { | a ... msg |
				msg[0] = '/r';
				netAddr.sendMsg(*msg);
			})
		}{
			netAddr.asSymbol.addAdapter(this, \msg, { | a ... msg |
				netAddr.sendMsg(*msg);
			})
		}
;
	}
	deleteReceiver { | netAddr |
		netAddr.asSymbol.removeAdapter(this, \msg);
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
	//----- Filters -----

	addFilter { | jointName, func |
		// TODO: Use JointController instead of ValueAdapter
		animator.addFilter(jointName, func);
	}

	getFilter { | joint | ^animator getFilter: joint }

	ctlvalues { ^controller.ctlvalues }
	ctlIndex { | joint | ^this.parser.ctlIndex(joint) }

	messages { ^sessionData.messages }
	parser { ^sessionData.parser }

	filterMessage { | message |
		animator filterMessage: message;
	}

	publishValueArray { | argMsg |
		// get numeric values from raw rokoko message
		// and publish them with changed \values
		this.changed(\values, sessionData.makeValueArray(argMsg))
	}
}