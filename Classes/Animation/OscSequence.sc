// 日 29  6 2025 14:03
// play back a sequence of times and osc messages
// obttained from an SessionData

OscSequence {
	var <times, <messages;
	var <task;
	var localAddr;
	var <>sendLocal = false;

	localAddr { ^localAddr ?? { localAddr = NetAddr.localAddr } }

	*new { | times, messages |
		^this.newCopyArgs(times, messages);
	}

	play {
		this.changed(\begin);
		task = Task({
			var message;
			times.size do: { | i |
				message = messages[i];
				this.changed(\msg, i, message);
				if (sendLocal) {
					this.localAddr.sendMsg(*message);
				};
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
			var message;
			inf do: { | i |
				this.changed(\loop, i);
				times.size do: { | j |
					message = messages[i];
					this.changed(\msg, j, message);
					if (sendLocal) {
						// "sending".postln;
						// message.postln;
						this.localAddr.sendMsg(*message);
					};
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
