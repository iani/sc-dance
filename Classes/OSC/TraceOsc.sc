// 木 26  6 2025 16:54

TraceOsc : NamedInstance {
	var <>excludedMessages = #[
			'/cbmon', '/status.reply', '/done', '/n_end',
			'/recordingDuration', '/n_go', '/d_removed', '/synced',
			'/groupclient/ping', '/minibeesmooth', '/c_setn'
		];
	var <>excludeServerMessages = true;
	enableOsc { this.enable }
	disableOsc { this.disable }
	enable { OscControl.enable addDependant: this; }
	disable { OscControl removeDependant: this; }
	update { | time, addr, msg |
		// [time, addr, msg, "DEBUGGING"].postln;
		if (excludeServerMessages and: {
			excludedMessages includes: msg[0]
		}) { 	//  skip excluded message
			// "I excluded".postln;
		}{
			[time, addr, msg].postln;
		}
	}
	postServer { excludeServerMessages = false }
	muteServer { excludeServerMessages = true }
}