//: 木  3  7 2025 16:44
//Testing status of data playback and forwarding
//from Rokoko to GODOT.

//Set up a player to play back test data:
//: Read all files from folder of session 250414_001919
//!!!! Edit the path given in the string "/Users..." to match
// the folder path of an existing recording session on your computer
~dataFolder = "/Users/iani/oscdata/";
~dataFolder.folders do: _.postln;
~sessionFolder = ~dataFolder.folders[2].fullPath;
~sessionFolder.folders do: { | f | f.folderName.postln };
~session = ~sessionFolder.folders[2].fullPath;
// note: on 土  5  7 2025 14:20 the first session folder showed a distorted movement
// trying the second session folder:
~session.folderName.postln;
~player = OscPlayer(~session);
//: play back entire session, looping forever:
//and trace to watch what is being played
~sequence = ~player.loop.simpleTrace;
~sequence.simpleUntrace; // stop posting
~sequence.simpleTrace; // start posting again
//:Prototype for forwarding based on Notification
//(Notification -> Adapter in this library, later).
//:activate
\rokokoTest.addAdapter(~sequence, \msg, { | ... args | args.postln });
//:deactivate
\rokokoTest.removeAdapter(~sequence, \msg);
//:Getting the actual data needed
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg | msg.postln });
//:Forward to net addresses:
//:first create addresses to listen to:
//:
~listeners = [
	// Godot on local computer:
	NetAddr("127.0.0.1", 22245), // add more addresses as needed
	];
//:Send as is (no format conversion)
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg |
	postln("sending to listeners:" + ~listeners);
	postln("sending" + msg);
	~listeners do: { | a |
		a.sendMsg(*msg);
	}
});
//:
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg |
	msg.size.postln;
});
//: FILTER THE DATA. First filter test!
~player = OscPlayer("/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_002557/");
//: play back entire session, looping forever:
//and trace to watch what is being played
~sequence = ~player.loop.simpleTrace;
~sequence.dontTrace;
//:
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg |
	msg.size.postln;
});
//:
\rokokoTest.removeAdapter(~sequence, \msg);
//:
~filter = nil ! 187;
//:

//:
//:
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg |
	msg = ~filter.filter(msg).postln;
	NetAddr("127.0.0.1", 22245).sendMsg(msg);
});
//:
~filter[2] = ValueAdapter({ 'giorgos' });
//:
~pat = (0..100).normalize(-0.5, 0.5).pseq.asStream;
//:

~filter[5] = ValueAdapter({ | in | in + ~pat.next });
f[2] = ValueAdapter({ 'giorgos' });
f filter: m;

//:
~sequence.pause;
//:
~sequence.resume;
//:
\rokokoTest.removeAdapter(~sequence, \msg);
//:
~listeners = [
	//	NetAddr.localAddr,
	NetAddr("127.0.0.1", 22245),
	// NetAddr("200.", 22245)
	// add remote addresses from mc later:
	// NetAddr("...", ...),
	// NetAddr("...", ...);
];
//:Now use send to these addresses:
\rokokoTest.addAdapter(b, \msg, { | n, i ... msg |
	// msg.postln;
	NetAddr.localAddr.sendMsg(\test, 1);
});
//:Now use send to these addresses:
//:1. Send as is (no format conversion)
\rokokoTest.addAdapter(~sequence, \msg, { | n, i ... msg |
	// postln("sending" + msg);
	msg =  ~filter.filter(msg).postln;
	~listeners do: { | a |
		a.sendMsg(*msg);
	}
});
//:Now use send to these addresses:
\rokokoTest.addAdapter(b, \msg, { | n, i ... msg |
	var converted;
	converted = ~converter.(msg);
	~rlisteners do: { | a |
		var converted;
		converted = ~converter.(msg);
		a.sendMsg(*converted);
	}
});
//:Adapter function for converting symbols to indices
//in rokoko osc message array.
~converter = { | msg |
	var all;
	all = msg[3..].clump(8).flop;
	// all.size.postln;
	// all[0].postln;
	//	all[0].size.postln;
	all[0] = (0..23);
	// all.flop.flat.postln;
	// alternative 1: drop header
	// ['/rokoko/'] ++ all.flop.flat;
	// alternative 2: include figure header:
	msg[..2] ++ all.flop.flat
};
//:Open OscMonitor to watch rokoko messages
OscMonitor.gui;
