// 金 11  7 2025 17:52
// send rokoko messages to local address, when playing
Avatar.addReceiver(NetAddr.localAddr);
//The above is equivalent to:
Avatar(\default).addReceiver(NetAddr.localAddr);
// Shortcuts
// Send to local godot instance
Avatar.addLocalGodot;
Avatar.deleteLocalGodot;
Avatar.addLocalSC;
Avatar.deleteLocalSC;
//:
Avatar.play;
Avatar.default.stop;
Avatar.addFilter(\hipx, { 2 });

//Select a session per gui and load it:
Avatar.sessionGui;
//:Creating other named avatars:
Avatar(\girl1);

OSCFunc.trace(true, true);
OSCFunc.trace(false);
//
