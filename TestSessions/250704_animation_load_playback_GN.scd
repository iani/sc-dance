// -------- 1. load a recording session ---------
// store recordings root folder
~recording_root = "/Users/Giorgos Nikopoulos/OSC_Recordings/OSCData/".standardizePath;
// list sessions in recording root
~folder_paths = PathName(~recording_root).folders;
// list folder names
~folder_paths do: { | p | p.folderName.postln };
// list sessions of each recording day
~folder_paths do: { | p | p.folders.postln };
// select one session folder from the list and copy it
~session = "/Users/Giorgos Nikopoulos/OSC_Recordings/OSCData/250703/250703_153754/";
// list the files in this session
PathName(~session).entries;
// -------- 2. play the session ---------
// create player for this session
~player = OscPlayer(~session);
// play the session
~sequence = ~player.loop;
// post OSC
~sequence.simpleTrace;
// stop posting
~sequence.simpleUntrace;
// stop playing
~sequence.stop;
// -------- 3. send OSC from playing sequence to clients ---------
//:first create addresses to listen to:
(
~listeners = [
	// Godot on local computer:
	NetAddr("127.0.0.1", 22245),
	// add more addresses as needed
	//          ip         port
	// NetAddr("200. ...", 22245)
	];
)
//:Send as is (no format conversion)
(
\rokokoTest.addNotifier(~sequence, \msg, { | n, i ... msg |
	~listeners do: { | a |
		a.sendMsg(*msg);
	}
});
)




