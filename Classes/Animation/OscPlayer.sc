//土 28  6 2025 16:51
//Read OSC Data from files in a folder creaated by OscRecorder.
//Parse into a timeline and play back selectively.

OscPlayer {
	var <folderPath, <filePaths;
	var <oscFiles, <times, <messages;

	*new { | path |
		^this.newCopyArgs(path).init;
	}

	init {
		filePaths = this getScdFiles: folderPath;
		this.readFiles;
		this.makeTimesMessages;
		// times = oscFiles collect: { | f | f.entries.flop[0] };
		// messages = oscFiles collect: { | f | f.entries.flop[1] }
	}

	getScdFiles { | argPath |
		var folder;
		if (this scdFileP: argPath) {
			^[argPath]
		}{
			^(argPath ++ "*.scd").pathMatch
		};
	}

	readFiles {
		oscFiles = filePaths collect: OscFile(_);
		// oscFiles = oscFiles select: { | f | f.entries.size > 0 }
		oscFiles do: { | f |
			f.filterMessages('/rokoko/');
			// "====== filtered entries are =========".postln;
			// f.entries.postln;
		};
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
}