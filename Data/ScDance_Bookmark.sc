// 日  6  7 2025 23:25
// This class returns the path of the Data directory.
// It should not moved elsewhere.
// See superclass Bookmark and its class methods for usage.

ScDanceSessions : RokokoSessionsBookmark {
	animationFolders {
		^this subfolders: "Animations"
	}
}
