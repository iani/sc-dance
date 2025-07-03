
//: prepare data playback for simulation:
//: Read all files from folder of session 250414_001919
a = OscPlayer("/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_001919/")
//: play back entire session, looping forever:
//and trace to watch what is being played
b = a.loop.simpleTrace;
b.simpleUntrace; // stop posting
b.simpleTrace; // start posting again

//:Set up forwarding.
OscControl.enable; // activate OscControl globally
//:set up addresses to forward rokoko osc to:
~rokokoListeners = [
	NetAddr("127.0.0.1", 22245),
	NetAddr("10.200.202.5", 22245)
];
//:attach a rokoko forwarder to OscControl.
// listen to message '/rokoko/'
// Note: OscControl issues \osc.changed!
\forwarder.addNotifier(\osc, '/rokoko/', { | n, msg |
	~rokokoListeners do: { | l |
		l.sendMsg(*msg);
	}
});
//:
\forwarder.removeNotifier(\osc, '/rokoko/');
//:
\osc.simpleTrace;
\osc.simpleUntrace;
b

"/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_001919/"