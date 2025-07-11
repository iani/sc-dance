// 木 10  7 2025 15:21
// Provide shared gui/api for handling path bookmarks for
// Rokoko Session data

RokokoSessionsBookmark : PathBookmark {
	var sessionsDict;
	var >defaultPath;

	*sessionGui {
		// this.subclasses.postln;
		Windows.makeWindow(this, \gui, { | w |
			var widgets;
			w.name = "Rokoko Sessions";
			widgets = this.subclasses collect: _.sessionListView;
			widgets = widgets add: StaticText().string_("Press enter to load session in Avatar.default");
			w.view.layout = VLayout(*widgets.flat);
			w.front;
		})
	}
	sessionNames {
		^this.sessionsDict.keys.asArray.sort;
	}
	sessionsDict {
		sessionsDict ?? { this.makeSessionsDict };
		^sessionsDict;
	}

	makeSessionsDict {
		sessionsDict = IdentityDictionary();
		this.animationFolders do: { | sd |
			sessionsDict[sd.folderName.asSymbol] = sd;
		};
	}

	animationFolders {
		^this subsubfolders: "Animations"
	}

	defaultPath {
		^defaultPath ?? {
			defaultPath = this.sessionsDict[this.sessionNames.first];
		}
	}

	*gui { this.default.gui }
	gui {
		Windows.makeWindow(this, name, { | w |
			var list;
			w.name = format("% : Select a session", this.class);
			w.view.layout = VLayout(
				list = ListView(),
				StaticText().string_("Press enter to load session in Avatar.default")
			);
			list.items = this.sessionNames;
			list.action = { | me |
				// me.items[me.value].postln;
			};
			list.value = 0;
			list.enterKeyAction = { | me |
				Avatar.default.load(this.sessionsDict[me.item.asSymbol]);
			};
			w.front;
		})
	}
	sessionListView {
		var list;
		list = ListView();
		list.items = this.sessionNames;
		list.action = { | me |
			// me.items[me.value].postln;
		};
		list.value = 0;
		list.enterKeyAction = { | me |
			Avatar.default.load(this.sessionsDict[me.item.asSymbol]);
		};
		^[StaticText().string_(this.asString), list];
	}
}