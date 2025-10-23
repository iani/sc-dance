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
Avatar addReceiver: NetAddr("192.168.12.147", 22245);
//------------------------------------------------------------
//Animate figure from SC
Avatar.putCtl(\hipy, { SinOsc.kr(0.3, 2pi) / 3 + 1.3 });
Avatar.putCtl(\rightLegqx, { SinOsc.kr(0.3) / 4 + 0.1});
Avatar.putCtl(\rightUpLegqx, { SinOsc.kr(0.3) / 4 + 0.1 });
Avatar.putCtl(\rightFootqy, { SinOsc.kr(0.3) / 4 + 0.3});
Avatar.putCtl(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.putCtl(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 - 0.2});
Avatar.putCtl(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.putCtl(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.putCtl(\chestqx, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\headqx, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\headqy, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\leftHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\leftHandqz, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\rightHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.putCtl(\rightHandqz, { SinOsc.kr(0.5) / 4 });

Avatar.removeSynths;
//: is the interpreter working?
//
10000.rand;