// 日 29  6 2025 14:03
// play back a sequence of times and osc messages
// obttained from an OscPlayer

OscSequence {
	var <times, <messages;
	var <routine;

	*new { | times, messages |
		^this.newCopyArgs(times, messages);
	}

	play {
		this.changed(\begin);
		routine = fork {
			times.size do: { | i |
				this.changed(\msg, i, messages[i]);
				((times[i + 1] ?? {
					times[i] }) - times[i]
				).wait;
			};
			this.changed(\end);
		}
	}

	loop {
		this.changed(\begin);
		routine = fork {
			inf do: { | i |
				this.changed(\loop, i);
				times.size do: { | j |
					this.changed(\msg, j, messages[j]);
					((times[j + 1] ?? {
						times[j] }) - times[j]
					).wait;
				}
			}
		}
	}

	stop { routine.stop; }
}
