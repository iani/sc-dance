// 土  5  7 2025 14:46
// Handle settings for an Avatar, and store them in a file.
// (Current version just stores the session paths for an Avatar:)
// Create dialog windows for selecting session path folders
// Create guis for viewing folders containing session data,
// and selecting a session to play.

AvatarSettings : NamedInstance {
	var <rootDir, sessions;
	*initClass {
		StartUp add: { this.init; };
	}

	*init { this.makeBaseDirectory; }

	*makeBaseDirectory {
		if (File.exists(this.baseDirectory).not) {
			File.mkdir(this.baseDirectory)
		}
	}

	*baseDirectory { ^Platform.userAppSupportDir +/+ "AvatarSettings"; }

	*gui { ^this.default.sessionGui }

	sessionGui {
		var window;
		window = Windows.makeWindow(this, name, { | w |
			this initWindow: w
		});
		window.front;
		^window;
	}

	initWindow { | window |
		var sessionList;
		"initing window".postln;
		window.bounds = Rect(100, 100, 600, 300);
		window.name = name.asString + "session folders";
		window.view.layout = VLayout(
			sessionList = ListView()
			.addAdapter(this, \rootDir, { | a |
				this.makeSessions;
				// rootDir.folders.collect(_.fullPath).postln;
				a.listener.items = sessions.keys.asArray.sort;
			})
		);
		this.checkRootDir;
		window.front;
	}

	makeSessions {
		"making sessions".postln;
		sessions = IdentityDictionary();
		rootDir.folders do: { | e |
			var basename, subfolder, sessionname;
			basename = e.folderName;
			e.entries do: { | f |
				subfolder = f.folderName;
				sessionname = format("%:%", basename, subfolder).asSymbol;
				sessions[sessionname] = f;
			};
		};
		^sessions;
	}

	checkRootDir {
		{
			if (rootDir.isNil) {
				"Select root directory for session data".postln;
				FileDialog({ | paths |
					rootDir = paths.first;
					this.changed(\rootDir);
				}, fileMode: 2);
			}{
				"root dir was not nil.".postln;
				"I notify changed rootDir".postln;
					this.changed(\rootDir);
			}
		}.defer;
	}

}