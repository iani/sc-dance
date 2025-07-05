//: 木  3  7 2025 16:44
//Testing status of data playback and forwarding
//from Rokoko to GODOT.

//Set up a player to play back test data:
//: Read all files from folder of session 250414_001919
//!!!! Edit the path given in the string "/Users..." to match
// the folder path of an existing recording session on your computer
a = OscPlayer("/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_002557/")
//: play back entire session, looping forever:
//and trace to watch what is being played
b = a.loop.simpleTrace;
b.simpleUntrace; // stop posting
b.simpleTrace; // start posting again
//:Prototype for forwarding based on Notification
//(Notification -> Adapter in this library, later).
//:activate
\rokokoTest.addNotifier(b, \msg, { | ... args | args.postln });
//:deactivate
\rokokoTest.removeNotifier(b, \msg);
//:Getting the actual data needed
\rokokoTest.addNotifier(b, \msg, { | n, i ... msg | msg.postln });
//:Forward to net addresses:
//:first create addresses to listen to:
~rlisteners = [
	//	NetAddr.localAddr,
	NetAddr("127.0.0.1", 22245),
	// NetAddr("200.", 22245)
	// add remote addresses from mc later:
	// NetAddr("...", ...),
	// NetAddr("...", ...);
];
//:Now use send to these addresses:
\rokokoTest.addNotifier(b, \msg, { | n, i ... msg |
	// msg.postln;
	NetAddr.localAddr.sendMsg(\test, 1);
});
//:Now use send to these addresses:
//:1. Send as is (no format conversion)
\rokokoTest.addNotifier(b, \msg, { | n, i ... msg |
	// postln("sending" + msg);
	~rlisteners do: { | a |
		// msg.postln;
		a.sendMsg(*msg); // .postln;
	}
});
//:
b.pause;
//:
b.resume;
//:Now use send to these addresses:
\rokokoTest.addNotifier(b, \msg, { | n, i ... msg |
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
