
OscControl : NamedInstance {
	var localId;
	*enable { thisProcess.recvOSCfunc = this }
	*disable {
		if { thisProcess.recvOSCfunc === this }{
			thisProcess.recvOSCfunc = nil
		}
	}

	*value { | time, addr, msg |
		this.changed(msg[0], msg, time, addr);
	}

}