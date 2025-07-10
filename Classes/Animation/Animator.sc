//:日  6  7 2025 07:42
//:Send '/rokoko/' messages to GODOT.
//:a
//:Get input from synths via Inbus.
//:Write
//:Note: dictionaris are created when obtaining the first message.

Animator {
	var <task, <messages, <times = 0.03;
	var <>filter;
	var <>rokokoParser;
	var <>jointDict, >avatar;

	// addr { ^addr ?? { addr = NetAddr("127.0.0.1", 22245) } }

	init { | argMessages |
		this.messages = argMessages.pseq;
	}

	checkJointDict { | argMessage |


	}

	messages_ { | argMessages | messages = argMessages.asStream }
	times_ { | argTimes | times = argTimes.asStream }

	makeJointDict { | message |

	}
	// filter { ^filter ?? { filter = this.makeFilter } }
	// makeFilter { ^nil ! msgCache.size; }

	*start { this.default.start }
	*stop { this.default.stop }
	*pause { this.default.pause }
	*resume { this.default.resume }
	*reset { this.default.reset }

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
	avatar { ^avatar ?? { Avatar(\default); } }

	stop { task.stop; this.reset; }
	pause { task.pause }
	resume { task.resume }
	reset { task.reset; messages.reset; times.reset; }

	// ================== FILTERS ====================
	addFilter { | func, joint, offset = 0 |
		var index, filterAdapter;
		// index = offset + msgCache.indexOf(joint);
		filterAdapter = ValueAdapter(func);
		this.filter[index] = filterAdapter;
	}

	removeFilter { | joint, offset = 0 |
		var index;
		// index = offset + msgCache.indexOf(joint);
		this.filter[index] = nil;
	}
}