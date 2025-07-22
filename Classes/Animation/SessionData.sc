//土 28  6 2025 16:51
//Read OSC Data from files in a folder creaated by OscRecorder.
//Parse into a timeline and play back selectively.

SessionData {
	var <folderPath, <>avatar, <filePaths;
	var <oscFiles, <times, <messages;
	var <parser;

	*new { | argPath, argAvatar |
		^this.newCopyArgs(argPath, argAvatar);
	}

	// playing data from live session
	calibrateRemote { | argOscAddress |
		"Preparing calibration".postln;
		messages = nil;
		TraceOsc.enable;
		avatar.addAdapter(OscControl, argOscAddress, { | a, msg |
			messages = messages add: msg;
			this.parser.parse(msg);
			postf("% of % has parsed message and is ready for activation\n",
				this, avatar
			);
			TraceOsc.disable;
			avatar.removeAdapter(OscControl, argOscAddress);
			avatar.addAdapter(OscControl, argOscAddress, { | a, msg |
				avatar.animator.message = msg;
			});
			avatar.controller.play;
		});
		OscControl.enable;
	}


	// playing data from file
	load { | argPath |
		// postf("Debugging SessionData.load. Path is:\n%\n", argPath);
		folderPath = argPath;
		this.loadData;
	}

	loadData {
		messages = [];
		this.readFiles;
		this.makeTimesMessages;
		this.updateParser;
	}

	getScdFiles { | argPath |
		var folder;
		if (this scdFileP: argPath) {
			^[argPath]
		}{
			^(argPath +/+ "*.scd").pathMatch;
		};
	}

	readFiles {
		// postf("Debugging SessionData.readFiles. folderPath is:\n%\n",
		// 	folderPath);
		filePaths = this getScdFiles: folderPath;
		// postf("Debugging SessionData.readFiles. filePaths is:\n%\n",
		// 	filePaths);
		oscFiles = filePaths collect: OscFile(_);
		// postf("Debugging SessionData.readFiles. oscFiles is:\n%\n",
		// 	oscFiles);
		// oscFiles do: { | f |
		// 	postf("Before filter: % has % entries\n", f, f.entries.size)
		// };
		oscFiles do: { | f |
			f.filterMessages('/rokoko/');
		};
		oscFiles = oscFiles select: { | f | f.entries.size > 0 }
		// oscFiles do: { | f |
		// 	postf("After filter: % has % entries\n", f, f.entries.size)
		// };
	}

	makeTimesMessages {
		oscFiles do: { | o |
			o.entries do: { | e |
				times = times add: e[0];
				messages = messages add: e[1]; // .interpret;
			};
		}
	}
	scdFileP { | argPath |
		^argPath[argPath.size-4..] == ".scd";
	}

	loop { | from = 0, to |
		^this.spawn(from, to).loop;
	}

	play { | from = 0, to |
		^this.spawn(from, to).play;
	}

	spawn { | from = 0, to |
		to ?? { to = times.size - 1; };
		^OscSequence(times[from..to], messages[from..to]);
	}

	updateParser {
		parser ?? { parser = RokokoParser(avatar) };
		parser.parse(messages.first);
	}

	makeValueArray { | argMsg |
		// filter numeric values from rokoko message in an array
		^parser.makeValueArray(argMsg);
	}
}