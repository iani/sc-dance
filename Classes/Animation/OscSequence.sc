// 日 29  6 2025 14:03
// play back a sequence of times and osc messages
// obttained from an OscPlayer

OscSequence {
	var <times, <messages;
	var <task;

	*new { | times, messages |
		^this.newCopyArgs(times, messages);
	}

	play {
		this.changed(\begin);
		task = Task({
			times.size do: { | i |
				this.changed(\msg, i, messages[i]);
				((times[i + 1] ?? {
					times[i] }) - times[i]
				).wait;
			};
			this.changed(\end);
		});
		task.start;
	}

	loop {
		this.changed(\begin);
		task = Task({
			inf do: { | i |
				this.changed(\loop, i);
				times.size do: { | j |
					this.changed(\msg, j, messages[j]);
					((times[j + 1] ?? {
						times[j] }) - times[j]
					).wait;
				}
			}
		});
		task.start;
	}

	pause { task.pause }
	resume { task.resume }
	stop { task.stop; }
}
