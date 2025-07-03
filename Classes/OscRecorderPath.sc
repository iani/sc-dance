// 金 27  6 2025 08:55
// Generate the path at the start of a new session, in
// response to method "sessionPath".
// OscRecorder calls sessionPath when starting to record
// in order to create a new folder to store the files of this session.
// Generate the full folder path only.  OscRecorder generates
// the filename and appends it to the folder path.
//
// Generate paths for OscRecorder:
// folder path = rootDir +/+ dayFolder +/+ sessionFolder
// rootDir:
// 	on MacOS: ~/Music/SuperCollider Recordings/
// 	on Windows: userHomeDir / "OSC_"
// 	on Linux:
// dayFolder: YYMMDD stamp of the date of the recording
// 				(Date.getDate.dayStamp)
// sessionFolder: YYMMDD_HHMMSS stamp of the start time of the recording
// 				(Date.localtime.stamp)
// file header: custom.  Defaults to "" (null string)
// time stamp: YYMMDD_HHMMSS stamp of the start time of this file data
//

OscRecorderPath : NamedInstance {
	var <rootDir;

	init { rootDir = this.makeRootDir }

	makeRootDir {
		if (thisProcess.platform.class.asSymbol === 'WindowsPlatform') {
			^PathName(Platform.userHomeDir +/+ "OSC_Recordings");
		};
		if (thisProcess.platform.class.asSymbol === 'OSXPlatform') {
			^PathName(Platform.userHomeDir +/+ "Music"
				+/+ "SuperCollider Recordings")
		}{
			^PathName(Platform.userAppSupportDir +/+ "OSC_Recordings");
		}
	}
	sessionPath {
		^rootDir.fullPath
		+/+ Date.getDate.dayStamp
		+/+ Date.localtime.stamp;
	}
}

	/*
	*makeDirectory {
		// is called by enable inside a fork, therefore does not delay execution.
		var errorCode;
		this.makeDailySubfolderTimestamp;
		// make directories for windows using File.mkdir.
		if (thisProcess.platform.class.asSymbol === 'WindowsPlatform') {
			File.mkdir(this.folderPath);
		}{
			// run command synchronously and collect error:
			errorCode = ("mkdir -p " ++ this.folderPath.replace(" ", "\\ ")).systemCmd;
			// TODO: find out which error signifies a problem, and catch it here
			// if (errorCode == ??? ) { issue a warning }
		}
	}
	*/
