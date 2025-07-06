//:日  6  7 2025 07:42
//simple shortcut for sending
R : NamedInstance {
	var >localAddr;
	var allAddr;
	var <task, <messages, <times = 0.03, <>filter;

	localAddr { ^localAddr ?? { localAddr = NetAddr("127.0.0.1", 22245) } }
	allAddr { ^allAddr ?? { allAddr = IdentityDictionary() } }

	messages_ { | argMessages | messages = argMessages.asStream }
	times_ { | argTimes | times = argTimes.asStream }

	send { | message |
		this.localAddr.sendMsg(*message)
	}

	broadcast { | message |
		this.allAddr do: { | a | a.sendMsg(*message) }
	}

	start {
		task.stop;
		task = Task({
			loop {
				this.send(messages.next);
				times.next.wait;
			};
		});
		task.start;
	}

	stop { task.stop }
	pause { task.pause }
	resume { task.resume }
}