//: 水  9  7 2025 17:13
//Access contents of a directory.
//Usage: Place a subclass of PathBookmark in the directory whose subfolders
//you need to list.

PathBookmark : NamedInstance {
	root { ^this.class.filenameSymbol.asString.pathOnly }
	folders {
		^this.root.folders;
	}

	subfolders { | folder |
		^(this.root +/+ folder).folders collect: _.fullPath;
	}

	subsubfolders { | folder |
		var subfolders, subsubfolders;
		subfolders = (this.root +/+ folder +/+ "").folders;
		postf("\n\n------- subfolders of % --------:\n are: %-------\n", this, subfolders);
		subfolders do: { | sf |
			postf("subfolders of %\n are: %\n", sf, sf.folders);
			sf.folders do: { | f | subsubfolders = subsubfolders add: f.fullPath };
		};
		^subsubfolders;
	}
}
