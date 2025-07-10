//:Read folders and put the names of subfolders as session names in a dictionary.
//List sessions.  Create a gui for selecting a session and loading it into an SessionData
//Create R and RControls instance for this session.
//

OscSessions : NamedInstance {
	var sessionPathsDict;

	sessionPathsDict {
		^sessionPathsDict ?? { sessionPathsDict = IdentityDictionary() }
	}

	init { | pathsArray |
		pathsArray do: { | p |
			this.sessionPathsDict[p.folderName.asSymbol] = p.fullPath;
		};
	}

	sessionNames { ^this.sessionPathsDict.keys.asArray.sort }

	sessionPath { | sessionName | ^this.sessionPathsDict[sessionName] }
	sessionFiles { | sessionName |
		^(this.sessionPath(sessionName) +/+ "*.scd").pathMatch }

	load { | argSessionPaths |
	}
}
