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

	play { this.start }
	start {
		task.stop;
		this.reset;
		task = Task({
			loop {
				var m;
				m = messages.next;
				avatar publishValueArray: m;
				avatar.changed(\msg, this.filterMessage(m));
				times.next.wait;
			};
		});
		task.start;
	}

	filterMessage { | argMessage |
		^filter filter: argMessage;
	}

	stop { task.stop; this.reset; }
	pause { task.pause }
	resume { task.resume }
	reset { task.reset; messages.reset; times.reset; }

	// ================== FILTERS ====================
	addFilter { | joint, func |
		// var index, filterAdapter;
		// index = offset + msgCache.indexOf(joint);
		// filterAdapter = ValueAdapter(func);
		// this.filter[index] = filterAdapter;
		// var index;
		// "Finding the index to put a filter in".postln;
		// index = msgDict[joint];
		// postf("the index for % is %\n", joint, index);
		filter[msgDict[joint]] = this.makeFilter(joint, func);
	}

	getFilter { | joint | ^filter[msgDict[joint]] }

	makeFilter { | joint, func |
		^JointFilter(func, avatar.ctlvalues, avatar ctlIndex: joint, joint);
	}

	removeFilter { | joint |
		//		var index;
		// index = offset + msgCache.indexOf(joint);
		// this.filter[index] = nil;
	}
}