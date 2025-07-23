// This is a live session.  Data are received from Rokoko MOCAP
// suit over the network and relayed to GODOT.
// We test the same modifications as with he prerecorded session.
//:Load default session to the default Avatar, open data gui, connect to GODOT, play:
OscUser.showCode;
//:Boot servers
s.boot; // Server must be booted to play Avatar!
//: Record sound to disc
Server.default.record;
//:At the end:
Server.default.stopRecording;
//:Test OSC reception
TraceOsc.enable;
//:Send a message to self to test:
NetAddr.localAddr.sendMsg(\test, 1, 2 ,3);
//:Wait to receive messages from Rokoko
//:After confirming reception from Rokoko, disable drace
TraceOsc.disable;
//:Enable remote reception and send to godot locally
Avatar.enableRemote.valuesGui.addLocalGodot;

Avatar.controller.play;
Avatar.controller.stop;
//:
Avatar.disableRemote;
//Filters: Override/modify the values of variables
//:Modify the value of joint hip at variable y
Avatar.addFilter(\hipy, 1.5);
//:Remove filter
Avatar.removeFilter(\hipy);
//:Synth functions as filters
//Add synth filter

Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.3) / 3 + 1.25 )});

//:stop the filter synth:
Avatar.removeSynth(\hipy);

//: Add control to variables of individual joints, one-by-one
//: Pause animation playback, to see control by synths only:
Avatar.removeSynths;
//: Add controls one-by-one (run one line at a time).
Avatar.putClt(\hipy, { SinOsc.kr(0.3, 2pi) / 3 + 1.3 });
Avatar.putClt(\rightLegqx, { SinOsc.kr(0.3) / 4 + 0.1});
Avatar.putClt(\rightUpLegqx, { SinOsc.kr(0.3) / 4 + 0.1 });
Avatar.putClt(\rightFootqy, { SinOsc.kr(0.3) / 4 + 0.3});
Avatar.putClt(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.putClt(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 - 0.2});
Avatar.putClt(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.putClt(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.putClt(\chestqx, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\headqx, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\headqy, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\leftHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\leftHandqz, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\rightHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.putClt(\rightHandqz, { SinOsc.kr(0.5) / 4 });
//:remove synths selectively
Avatar.removeSynth(\hipy);
Avatar.removeSynth(\rightLegqx);
Avatar.removeSynth(\rightUpLegqx);
Avatar.removeSynth(\rightFootqy);
Avatar.removeSynth(\leftLegqx);
Avatar.removeSynth(\leftUpperArmqx);
Avatar.removeSynth(\leftLowerArmqz);
Avatar.removeSynth(\rightUpperArmqx);
Avatar.removeSynth(\rightLowerArmqz);
Avatar.removeSynth(\chestqy);
Avatar.removeSynth(\chestqx);
Avatar.removeSynth(\headqx);
Avatar.removeSynth(\headqy);
Avatar.removeSynth(\leftHandqy);
Avatar.removeSynth(\leftHandqz);
Avatar.removeSynth(\rightHandqy);
Avatar.removeSynth(\rightHandqz);

//:Add animation of playback on top of synth-controlled animation
Avatar.resume;
//Remove all synth filters - back to playing animation from data only
Avatar.removeSynths;
//: Stop animation
Avatar.stop;
//:
