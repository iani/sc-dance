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
	classvar localGodotAddr;
	var <>sessionPath;
	var <sessionData, <animator, <controller;

	*localGodotAddr {
		^localGodotAddr ?? { localGodotAddr = NetAddr("127.0.0.1", 22245); }
	}
	*sessionGui { RokokoSessionsBookmark.sessionGui }

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

	play {
		if (sessionData.isNil) {
			^"Cannot play without data. Load a session.".postln;
		};
		animator.play;
		controller.play;
	}

	load { | path |
		var messages;
		sessionPath = path;
		this.stop;
		postf("Loading session data from\n%\ninto %\n",
			path, this
		);
		sessionData load: sessionPath;
		messages = sessionData.messages;
			postf("\Loaded % messages", messages.size;
		);
		animator.messages = messages.pseq;
	}

	msgStream {}
	timeStream {}

	stop {
		animator.stop;
		controller.stop;
	}

	messages { ^sessionData.messages }
	parser { ^sessionData.parser }

	//----- adding/removing OSC receivers-----
	addReceiver { | netAddr | // asSymbol: guarante matching
		netAddr.asSymbol.addAdapter(this, \msg, { | a ... msg |
			netAddr.sendMsg(*msg);
		});
	}
	deleteReceiver { | netAddr |
		netAddr.asSymbol.removeAdapter(this, \msg);
	}
	//----- Filters -----

	addFilter { | jointName, func, val |
		// TODO: Use JointController instead of ValueAdapter
		animator.addFilter(jointName, func, val);
	}
}