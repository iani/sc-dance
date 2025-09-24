//: Testing new framework of Live Coing in Godot with MC,
// For presentation in ChiGreece25
//: preliminary tests: ensure playback of data to SC and to local godot:

//: Test tracing
TraceOsc.enable;
NetAddr.localAddr.sendMsg(\test);
//: Test playback of MOCAP Data to self
Avatar.default.sendToSelf;
Avatar.default.play;
//: Test sending to local godot session
Avatar.sendToGodot;
//: Send to remote Godot session
Avatar addReceiver: NetAddr("", 22245);
