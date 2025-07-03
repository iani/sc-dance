/* 土 28  6 2025 11:21
Redo of OSCRecorder3 from sc-hacks-redux

Note:
Make directory and make file method wait for the directory or the
file to exist before continuing.


*/

OscRecorder : NamedInstance {
	var <>data;
	var <>maxItems = 1000; // Keep files small!
	var <>excludedMessages;
	var <>verbose = false;
	var <>filter; // if true, ignore the message
	var <sessionPath, <filePath, <file;

	init {
		excludedMessages = [
			'/cbmon', '/status.reply', '/done', '/n_end',
			'/recordingDuration', '/n_go', '/d_removed', '/synced', '/minibee/rssi',
			'/localhostInLevels', '/localhostOutLevels', '/groupclient/ping', '/minibeesmooth'
		];
		filter = { | msg | excludedMessages includes: msg };
		ShutDown add: { this.closeFile };
	}

	// record only messages included in argument list
	// (+ code messages from local evaluation!)
	// Note: internal code messages (from locally evaluated code), are always
	// recorded by default, (even when OscGroups is disabled!).
	record {
		if (this.isEnabled) {
			^"OSCRecorder is already running. Skipping this.".postln;
		}{ this.startSession };
	}

	startSession {
		var check;
		sessionPath = OscRecorderPath.sessionPath;
		check = File.mkdir(sessionPath);
		if (check.not) {
			postln("Could not create directory:" + sessionPath);
			^"OscRecorder cannot start recording".postln;
		};
		postln("OscRecorder made session path:" + sessionPath);
		this.enable;
	}

	enable {
		// make file.  Enable after file has been created.
		this.makeFile;
		OscControl.enable;
		OscControl addDependant: this;
		this.changed(\enabled_p, true);
	}

	makeFile { | completionFunc |
		// make and open file for writing data at current file path.
		// close old file and switch to new one after 0.1 seconds.
		var oldFile;
		oldFile = file;
		filePath = this.fullPath;
		postln("OscRecorder will open new file here:" + filePath);
		file = File.open(filePath, "w");
		data = [];
		{ oldFile !? { oldFile.close } } defer: 0.1;
		if (file.isOpen) {
			"The file is open. Continuing with the recording.".postln;
		}{
			postln("Can't open file" + filePath);
			"stopping the recording".postln;
			this.disable;
		};
	}

	/*
	makeFileBuggy { | completionFunc |
		// make and open file for writing data at current file path.
		// execute completion func 0.1 seconds after opening the
		// file, to ensure it is open.
		var newPath, newFile;
		completionFunc ?? {
			completionFunc = { | argFile | file = argFile };
		};
		newPath = this.fullPath;
		postln("OscRecorder will open new file here:" + newPath);
		newFile = File.open(newPath, "w");
		if (newFile.isOpen) {
			"The file is open. Continuing with the recording.".postln;
			filePath = newPath;
			completionFunc.(newFile);
		}{
			postln("Can't open file" + newPath);
			"stopping the recording".postln;
			this.disable;
		};
	}
	*/

	fullPath {
		sessionPath ?? { sessionPath = OscRecorderPath.sessionPath };
		^sessionPath +/+ Date.localtime.stamp ++ ".scd";
	}

	exclude { | ... argMessages |
		excludedMessages = excludedMessages ++ argMessages;
	}

	osc { | time, addr, msg |
		if (
			// excludedMessages includes: msg[0]
			filter.(msg[0])
		) {
			// do not record excluded message!
			if (verbose) { postln("osc recorder ignores: " + msg[0]); };
		}{
			this.addData(time, msg);
		}
	}

	addData { | time, msg |
		if (file.isNil or: { file.isOpen.not}) {
			file.postln;
			postln("File is open:" + file.isOpen);
			// postln("File path" + file.pathName);
			// postln("File exists" + File.exists(file.pathName));
			"OscRecorder file is not open for writing. Please check!".postln;
			^nil; // do not save or record if file is closed!
		};
		data = data add: [time, msg];
		// ensure code messages are stored as strings:
		if (msg[0] == '/code') {
			msg[1] = msg[1].asString;
		};
		file.putString("\n//:--[" ++ time.asCompileString ++ "]\n");
		file.putString(msg.asCompileString);
		if (data.size >= maxItems) { this.makeFile }
	}

	stopRecording {
		this.disable;
		// this closeFile: file;
		file.close;
		postln("OscRecorder stopped recording at:" + filePath);
	}

	closeFile { | argFile |
		"Debugging close file".postln;
		postln("argFile === file?" + (argFile === file));
		if (argFile.notNil) {
			argFile.close;
			postln("OscRecorder closed file:\n" + argFile);
		}{
			"OscRecorder cannot close file nil".postln;
		}
	}

	disable {
		OscControl removeDependant: this;
		this.changed(\enabled_p, false);
	}

	isRecording { ^this.isEnabled; }
	isEnabled { ^OscControl.dependants includes: this }

}