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
	var <>sessionPath;
	var <sessionData, <animator, <controller;

	init { | argSessionPath |
		this.load(argSessionPath ?? { ScDanceSessions.defaultPath });
	}

	play {
		if (animator.isNil) {
			^"Cannot play without data. Load a session.".postln;
		};
		animator.play;
		controller.play;
	}

	load { | path |
		var messages;
		// { path.postln; } ! 50;
		this.stop;
		sessionData = SessionData(path).avatar = this;
		messages = sessionData.messages;
		// animator = Animator().init(messages);
		// controller = AnimationController().init(messages);
	}

	msgStream {}
	timeStream {}

	stop {
		animator.stop;
		controller.stop;
	}

	messages { ^sessionData.messages }
}