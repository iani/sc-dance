// 日  6  7 2025 23:25
// This class returns the path of the Data directory.
// It should not moved elsewhere.
// See superclass Bookmark and its class methods for usage.

ScDanceAssets : AvatarAssets {
	var buffers;
	*initClass {
		ServerBoot add: { this.loadBuffers }
	}
	buffers { ^buffers ?? { buffers = IdentityDictionary() } }
	animationFolders { ^this subfolders: "Animations" }
	soundFiles { ^this.files("Audiofiles"); }

	loadBuffers {
		this.freeBuffers;
		this.loadSoundFiles;
	}

	freeBuffers { this.buffers do: _.free; }
	loadSoundFiles {
		var s, b;
		s = Server.default;
		fork {
			this.soundFiles do: { | f |
				b = Buffer.read(s, f);
				s.sync;
				this.buffers[f.fileNameWithoutExtension.asSymbol] = b;
			};
			postf("sc-dance loaded % buffers\n", buffers.size);
		}
	}
	bufNames { ^this.buffers.keys.asArray.sort }
}
