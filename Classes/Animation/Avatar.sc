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

	// filter and relay messages received via OSC
	enableRemote { | argOscAddress = '/rokoko/' |
		oscAddress = argOscAddress;
		this.stop; // stop playback from data;
		OscControl.enable;
		this.addAdapter(OscControl, oscAddress, { | a, msg |
			animator filterAndPublish: msg;
		});
	}

	disableRemote {
		this.removeAdapter(OscControl, oscAddress);
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

	//----- Filters -----
	// naming issue: Perhaps addCopyFilter is clearer?
	addSimpleFilter { | jointName | this addFilterc: jointName }
	addCopyFilter { | jointName | this addFilterc: jointName }
	addFilterc { | jointName | // wcontrol values
		this.addFilter(jointName, { | m, c | c })
	}

	addSumFilter { | jointName | this addFiltermpc: jointName }
	addFiltermpc { | jointName | // wcontrol values
		this.addFilter(jointName, { | m, c | m + c })
	}

	addProductFilter { | jointName | this addFiltermxc: jointName }
	addFiltermxc { | jointName | // wcontrol values
		this.addFilter(jointName, { | m, c | m * c })
	}

	addFilter { | jointName, func | animator.addFilter(jointName, func); }
	removeFilter { | joint | animator removeFilter: joint }
	getFilter { | joint | ^animator getFilter: joint }
	removeFilters { animator.removeFilters }
	ctlvalues { ^controller.ctlvalues }
	ctlIndex { | joint | ^this.parser.ctlIndex(joint) }
	messages { ^sessionData.messages }
	messageSize { ^sessionData.messages.first.size }
	parser { ^sessionData.parser }

	filterMessage { | message |
		animator filterMessage: message;
	}

	publishValueArray { | argMsg, publishMsg = \rawValues |
		// get numeric values from raw rokoko message
		// and publish them with changed \values
		this.changed(publishMsg, sessionData.makeValueArray(argMsg))
	}

	// =========== SYNTHS + Control (of controlbus) ============

	addSynth { | key, synthFunc | controller.addSynth(key, synthFunc) }
	removeSynth { | key | controller.removeSynth(key) }
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
				~filtview =
				filtview = MultiSliderView()
			);
			rawview.thumbSize = 3;
			filtview.thumbSize = 3;
			rawview.addAdapter(this, \rawvalues, { | a ... values |
				{
					a.listener.value = ([-2.0, 2.0] ++ values).normalize[2..];
				}.defer;
			});
			rawview.onClose = { | me |
				me.removeAdapter(this, \rawvalues);
			};
			filtview.addAdapter(this, \ctlvalues, { | a ... values |
				{
					a.listener.value = ([-2.0, 2.0] ++ values).normalize[2..];
				}.defer;
			});
			filtview.onClose = { | me |
				me.removeAdapter(this, \ctlvalues);
			};
			w.front;
		})
	}
}