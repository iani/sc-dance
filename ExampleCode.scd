
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
//L shorter forms:
Avatar.setSynth(\hipy, { SinOsc.kr(0.3) / 3 + 1.25 });
Avatar.setSynth(\rightLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightUpLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightFootqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.setSynth(\chestqx, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\headqx, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\headqy, { SinOsc.kr(0.5) / 4 });
//:
Avatar.resume;
//Remove all synth filters
Avatar.removeSynths;
//:

//Load default session to the default Avatar, open data gui, connect to GODOT, play:
Avatar.load.sendToGodot.play;
//Pause playing
Avatar.pause;
//Resume playing
Avatar.resume;
//Filters: Override/modify the values of variables
//Modify the value of joint hip at variable y
Avatar.addFilter(\hipy, 1.5);
//Remove filter
Avatar.removeFilter(\hipy);
//Synth functions as filters
//Add synth filter

Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.3) / 3 + 1.25 )});
//L shorter forms:
Avatar.setSynth(\hipy, { SinOsc.kr(0.3) / 3 + 1.25 });
Avatar.setSynth(\rightLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightUpLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightFootqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.setSynth(\chestqx, { SinOsc.kr(0.5) / 4 });
//Remove all synth filters
Avatar.removeSynths;
//:

//Load default session to the default Avatar, open data gui, connect to GODOT, play:
Avatar.load.sendToGodot.play;
//Pause playing
Avatar.pause;
//Resume playing
Avatar.resume;
//Filters: Override/modify the values of variables
//Modify the value of joint hip at variable y
Avatar.addFilter(\hipy, 1.5);
//Remove filter
Avatar.removeFilter(\hipy);
//Synth functions as filters
//Add synth filter
Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.3) / 3 + 1.25 )});
//Remove synth filter
Avatar.removeSynth(\hipy)
Avatar.set(\hipy, 1);

//: shorter forms:
Avatar.setSynth(\hipy, { SinOsc.kr(0.3) / 3 + 1.25 });
Avatar.setSynth(\rightLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightUpLegqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\rightFootqx, { SinOsc.kr(0.3) / 4 });
Avatar.setSynth(\leftLegqx, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\leftUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\leftLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\rightUpperArmqx, { SinOsc.kr(0.5) / 4 + 0.2});
Avatar.setSynth(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\rightLowerArmqz, { SinOsc.kr(0.5) / 4 });
Avatar.setSynth(\chestqy, { SinOsc.kr(0.5) / 4 + 0.2 });
Avatar.setSynth(\chestqx, { SinOsc.kr(0.5) / 4 });
//Remove all synth filters
Avatar.addFilter(\hipy, 1.0);

Avatar.removeSynth(\chestqz)
Avatar.removeSynths;
//: shorter forms:
Avatar.setSynth(\hipy, { LFNoise1.kr(0.3) / 3 + 1.25 });
Avatar.setSynth(\rightLegqx, { LFNoise1.kr(0.83) / 4 });
Avatar.setSynth(\rightUpLegqx, { LFNoise1.kr(0.83) / 4 });
Avatar.setSynth(\rightFootqx, { LFNoise1.kr(0.83) / 4 });
Avatar.setSynth(\leftUpLegqx, { LFNoise1.kr(0.85) / 4 });
Avatar.setSynth(\leftLegqx, { LFNoise1.kr(0.95) / 4 });
Avatar.setSynth(\leftFootqx, { LFNoise1.kr(0.95) / 4 });
Avatar.setSynth(\leftUpperArmqx, { LFNoise1.kr(0.95) / 4 + 0.2});
Avatar.setSynth(\leftLowerArmqz, { LFNoise1.kr(0.95) / 4 });
Avatar.setSynth(\rightUpperArmqx, { LFNoise1.kr(0.95) / 4 + 0.2});
Avatar.setSynth(\rightLowerArmqz, { LFNoise1.kr(0.95) / 4 });
Avatar.setSynth(\chestqy, { LFNoise1.kr(0.95) / 4 + 0.2 });
Avatar.setSynth(\chestqx, { LFNoise1.kr(0.5) / 4 });
//Remove all synth filters
Avatar.removeSynths;
//:
Avatar.setSynth(\leftHandqz, { SinOsc.kr(0.95) / 8 });
Avatar.setSynth(\rightHandqz, { SinOsc.kr(0.95) / 8 });
Avatar.setSynth(\rightHandqx, { SinOsc.kr(0.95) / 8 });
Avatar.setSynth(\rightHandqy, { SinOsc.kr(0.95) / 8 });
//:
Avatar.jointNames;

//: Debugging:

Avatar.addSynth(\test, { SinOsc.ar(400) / 18 });


//:Sound
// TBD
//:Trigger a sound for each joint,
// Based from the sum of slopes (rates of chaneges)
/*
Avatar.addSynth(\slopecluster23, {
	var src;
	src = Avatar.controller.ioArray.reverse.clump(7) collect: { | jg, i |
		var freq, vars, freqs, slopes, slopeSum, trig;
		freq = (i * 5 + 40).midicps;
		vars = jg collect: { | j | j.avatarIn.lag(1.5) };
		slopes = vars collect: { | v | Slope.kr(v).abs;};
		slopeSum = Mix(slopes);
		freqs = vars collect: { | v |
			v.linlin(-2, 2.0, 1.0, 2.0) * freq;
		};
		trig = Trig1.kr(slopeSum > 0.5) * 0.01;
		Mix(SinOsc.ar(freqs, 0, Decay2.kr(trig) * 0.03));
	};
	Mix(src).dup;
});
*/