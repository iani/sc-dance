
//Load default session to the default Avatar, open data gui, connect to GODOT, play:
//:Boot servers
s.boot; // Server must be booted to play Avatar!
Avatar.load.valuesGui.sendToGodot.play; // connect to GODOT, show gui, start playing
//Pause playing
Avatar.pause;
//Resume playing fd
Avatar.resume;
//Filters: Override/modify the values of variables
//Modify the value of joint hip at variable y
Avatar.addFilter(\hipy, 1.5);
//Remove filter
Avatar.removeFilter(\hipy);
//Synth functions as filters
//Add synth filter

Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.3) / 3 + 1.25 )});

//:stop the filter synth:
Avatar.removeSynth(\hipy);

// Add control to variables of individual joints, one-by-one
// Pause animation playback, to see control by synths only:
Avatar.pause;
// Add controls one-by-one (run one line at a time).
Avatar.addCtl(\hipy, { SinOsc.kr(0.3) / 3 + 1.5 });
Avatar.addCtl(\rightLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.addCtl(\rightUpLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.addCtl(\rightFootqx, { SinOsc.kr(0.3) / 4 });
Avatar.addCtl(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.addCtl(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 - 0.2});
Avatar.addCtl(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.addCtl(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.addCtl(\chestqx, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\headqx, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\headqy, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\leftHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\leftHandqz, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\rightHandqy, { SinOsc.kr(0.5) / 4 });
Avatar.addCtl(\rightHandqz, { SinOsc.kr(0.5) / 4 });
//
//:Add animation of playback on top of synth-controlled animation
Avatar.resume;
//Remove all synth filters - back to playing animation from data only
Avatar.removeSynths;
//: Stop animation
Avatar.stop;
//:
