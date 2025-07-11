//:日  6  7 2025 07:42
//:Send '/rokoko/' messages to GODOT.
//:a
//:Get input from synths via Inbus.
//:Write
//:Note: dictionaris are created when obtaining the first message.

Animator {
	var <>avatar, <task, <messages, <times = 0.03;
	var <>filter;
	var <msgDict, <ctlDict;

	*new { | avatar | ^this.newCopyArgs(avatar).init }

	init {
		this.addAdapter(avatar, \messageFormat, { | a, parser |
			msgDict = parser.msgDict;
			ctlDict = parser.ctlDict;
			filter = { nil } ! parser.message.size;
		})
	}

	messages_ { | argMessages | messages = argMessages.asStream }
	times_ { | argTimes | times = argTimes.asStream }

	makeJointDict { | message |

	}
	// filter { ^filter ?? { filter = this.makeFilter } }
	// makeFilter { ^nil ! msgCache.size; }

	*play { this.default.start }
	*start { this.default.start }
	*stop { this.default.stop }
	*pause { this.default.pause }
	*resume { this.default.resume }
	*reset { this.default.reset }

	play { this.start }
	start {
		task.stop;
		this.reset;
		task = Task({
			loop {
				this.avatar.changed(\msg, filter.filter(messages.next));
				times.next.wait;
			};
		});
		task.start;
	}

	stop { task.stop; this.reset; }
	pause { task.pause }
	resume { task.resume }
	reset { task.reset; messages.reset; times.reset; }

	// ================== FILTERS ====================
	addFilter { | joint, func, val = 0 |
		// var index, filterAdapter;
		// index = offset + msgCache.indexOf(joint);
		// filterAdapter = ValueAdapter(func);
		// this.filter[index] = filterAdapter;
		// var index;
		// "Finding the index to put a filter in".postln;
		// index = msgDict[joint];
		// postf("the index for % is %\n", joint, index);
		filter[msgDict[joint]] = ValueAdapter(func, val);
	}

	removeFilter { | joint |
		//		var index;
		// index = offset + msgCache.indexOf(joint);
		// this.filter[index] = nil;
	}
}