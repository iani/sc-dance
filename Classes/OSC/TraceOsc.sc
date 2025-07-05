// 木 26  6 2025 16:54

TraceOsc : NamedInstance {
	var <>excludedMessages = #[
			'/cbmon', '/status.reply', '/done', '/n_end',
			'/recordingDuration', '/n_go', '/d_removed', '/synced',
			'/groupclient/ping', '/minibeesmooth'
		];
	var <>excludeServerMessages = true;
	enableOsc { this.enable }
	disableOsc { this.disable }
	enable { OscControl addDependant: this; }
	disable { OscControl removeDependant: this; }
	update { | time, addr, msg |
		if (excludeServerMessages and: {
			excludedMessages includes: msg[0]
		}) { 	//  skip excluded message
		}{
			[time, addr, msg].postln;
		}
	}
	postServer { excludeServerMessages = false }
	muteServer { excludeServerMessages = true }
}