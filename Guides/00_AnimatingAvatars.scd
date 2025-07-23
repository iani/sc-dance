//:Preliminary: Show evaluated code in separate sc window:
OscUser.showCode;
//:Load default session to the default Avatar, open data gui, connect to GODOT, play:
//:Boot servers
s.boot; // Server must be booted to play Avatar!
Avatar.load.valuesGui.sendToGodot.play; // connect to GODOT, show gui, start playing
//: Add an address of a remote client to send to:
//: Address of mc for tests / demos: (only for remote testing)
Avatar addReceiver: NetAddr("10.200.202.14", 22245);
//:Pause playing
Avatar.pause;
//:Resume playing fd
Avatar.resume;
//Filters: Override/modify the values of variables
//:Modify the value of joint hip at variable y
Avatar.addFilter(\hipy, 1.5);
//:Remove filter
Avatar.removeFilter(\hipy);
//:Synth functions as filters
//Add synth filter

Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.3) / 3 + 1.3 )});

//:stop the filter synth:
Avatar.removeSynth(\hipy);

//: Add control to variables of individual joints, one-by-one
//: Pause animation playback, to see control by synths only:
Avatar.pause;
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
//
//:Add animation of playback on top of synth-controlled animation
Avatar.resume;
//Remove all synth filters - back to playing animation from data only
Avatar.removeSynths;
//: Stop animation
Avatar.stop;