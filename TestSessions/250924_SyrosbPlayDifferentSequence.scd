//: Select a new sequende to play back to Raven figure
// For presentation in ChiGreece25

//:initial version
// Run this to select a different session;
AvatarAssets.sessionGui;
//: Test tracing
TraceOsc.enable;
NetAddr.localAddr.sendMsg(\test);
//: Test playback of MOCAP Data to self
Avatar.default.sendToSelf;
Avatar.default.play;
//: Test sending to local godot session
Avatar.sendToGodot;
//:------------------------------------------------------------
// Switching between different sessions per code
//:post session names:
AvatarAssets.allSessionNames.asCompileString;
//:These are the session names:
 [ '250414_001919', '250414_002557', '250414_003102',
	 '250414_003228', '250414_003407', '250414_003725',
	 '250624_182908', '250624_183038', '250624_183051',
	 '250624_191551', '250624_194221', '250624_194900',
	 '250624_200601', 'fidgety_introvert', 'speed_contrast'
 ];
//:Load a session by name
Avatar loadNamed: \fidgety_introvert
//: Prepare avatar and play locally.
Avatar.sendToGodot;
Avatar.play;
//:load a different sesin and play it.
//note; Loading a session stops playing. One needs to start
//playing the new session from the beginning.

Avatar loadNamed: \speed_contrast;
Avatar.play;

//------------------------------------------------------------
//: Trying this also with an Avatar with a different name.
Avatar(\raven).sendToGodot;
Avatar(\raven) loadNamed: \speed_contrast;
Avatar(\raven).play;

//: Monitor to see where the Avatar name is sent in OSC message:
Avatar(\raven).sendToSelf;
TraceOsc.enable;

Avatar(\raven).stop;

//------------------------------------------------------------
//Preliminary session access tests
//:Get a session:
a = AvatarAssets sessionNamed: \fidgety_introvert;
// Returns path to session data as String:
a.class;
//:

//: Send to remote Godot session
Avatar addReceiver: NetAddr("192.168.12.147", 22245);
