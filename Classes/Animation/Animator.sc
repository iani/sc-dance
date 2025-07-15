//:日  6  7 2025 07:42
//:Send '/rokoko/' messages to GODOT.
//:a
//:Get input from synths via Inbus.
//:Write
//:Note: dictionaris are created when obtaining the first message.

Animator {
	var <>avatar, <task, <messages, <>message, <times = 0.03;
	var <>filter;
	var <msgDict, <ctlDict;
	var <props;

	*new { | avatar | ^this.newCopyArgs(avatar).init }

	init {
		props = Props(avatar);
		this.addAdapter(avatar, \messageFormat, { | a, parser |
			msgDict = parser.msgDict;
			ctlDict = parser.ctlDict;
			this.resetFilters;
		})
	}

	resetFilters {
		filter = { nil } ! avatar.messageSize;
		filter[2] = BasicFilter(avatar.name);
	}

	messages_ { | argMessages | messages = argMessages.asStream; }

	times_ { | argTimes | times = argTimes.asStream }

	play { this.start }
	start {
		task.stop;
		avatar.disableRemote;
		this.reset;
		task = Task({
			loop {
				// this filterAndPublish: messages.next;
				message = messages.next;
				times.next.wait;
			};
		});
		task.start;
	}

	filterAndPublish { | argMessage |
		var raw, filtered;
		raw = argMessage;
		filtered = this.filterMessage(raw);
		avatar.publishValueArray(raw, \rawmsg);
		avatar publishValueArray: filtered;
		avatar.changed(\msg, filtered);
	}

	filterMessage { | argMessage | ^filter filter: argMessage; }
	stop { task.stop; this.reset; }
	pause { task.pause }
	resume { task.resume }
	reset { task.reset; messages.reset; times.reset; }

	// ================== FILTERS ====================
	addFilter { | joint, func |
		filter[msgDict[joint]] = this.makeFilter(joint, func);
	}

	getFilter { | joint | ^filter[msgDict[joint]] }

	makeFilter { | joint, func |
		^JointFilter(func, avatar.ctlvalues, avatar ctlIndex: joint, joint);
	}

	removeFilter { | joint |
		filter[msgDict[joint]] = nil;
	}

	// remove all filters
	removeFilters { this.resetFilters }
}