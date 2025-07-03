// 土 28  6 2025 17:24
// Parse osc data from a single file.
// Used by OscPlayer

OscFile {
	var <path, <contents, <entries;

	*new { | path |
		^this.newCopyArgs(path).init;
	}

	init {
		contents = File.readAllString(path);
		this parseString: contents;
	}

	parseString { | string |
		// parse a string read from a file, in the format of //:--[timestamp] message.
		// Add all parsedEntries found to parsedEntries.
		var delimiters, header, entry;
		var timebeg, timeend;
		delimiters = string.findAll("\n//:--[");
		header = header ++ string[..delimiters.first] ++ "\n";
		delimiters do: { | b, i |
			var end;
			end = delimiters[i + 1];
			if (end.notNil) {
				entry = string.copyRange(b, end);
			}{
				entry = string.copyRange(b, string.size - 1)
			};
			timebeg = entry.find(":--[");
			timeend = entry.find("]", 4);
			entries = entries add: [
				entry.copyRange(timebeg + 4, timeend - 1).interpret,
				entry.copyRange(timebeg - 2,
					if (end.notNil) { entry.size - 2 } { entry.size - 1 })
			];
		};
		post(".");
	}
}