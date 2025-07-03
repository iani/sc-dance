
OscControl {
	classvar listeners;

	*enable { thisProcess.recvOSCfunc = this }
	*disable {
		if { thisProcess.recvOSCfunc === this }{
			thisProcess.recvOSCfunc = nil
		}
	}
	*listeners {
		^listeners ?? {
			listeners = MultiLevelIdentityDictionary()
		}
	}

	*value { | time, addr, msg |
		this.dependants do:  { | l | l.osc(time, addr, msg); };
		this.listeners[msg[0]] do: { | l | l.osc(time, addr, msg); };
		\osc.changed(msg[0], msg, time, addr);
	}

	*addListener { | listener, key |
		var l, key1, key2;
		#key1, key2 = this.makeKeys(listener, key);
		l = this.listeners.at(key1, key2);
		l ?? {
			l = Set();
			this.listeners.put(key1, key2, l);
		};
		l add: listener;
	}

	*makeKeys { | listener, key |
		^[listener.class, key ?? { listener.name }]
	}

	*removeListener { | listener, key |
		this.listeners.at(
			*this.makeKeys(listener, key)
		) remove: listener;
	}
}