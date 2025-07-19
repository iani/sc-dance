// 水 16  7 2025 10:58
// 1. Test Amplitude, Slope to sonify rate of change
// Start:
Avatar.loadNamed(\speed_contrast).valuesGui.sendToGodot.play;
//:Double check joint names:
Avatar.jointNames;
//:add a sound sonifying slope of head rotation x
Avatar.addCopySynth(\hipqy, { SinOsc.kr(0.2) / 2 }); // rotate hip @ y axis
//:The same with addSynth:
Avatar.addSynth(\hipqy, {
	~hipqy.out(SinOsc.kr(0.2) / 2)
}); // rotate hip @ y axis
//:Access to message busses and control busses
// Each joint variable is available as environment variable.
// List available joint variables:
Avatar.jointNames;
// each joint environment variable contains both the control bus
// and the animation bus:


//:
Avatar.addSynth(\headqx, {
	var qx;
	qx = ~leftUpperArmqx.avatarIn.lag(1.5);
	qx = Slope.kr(qx).abs;
	SinOsc.ar(qx.linlin(0, 10, 200, 4000), 0, 0.1).dup;
});
//:add a sound sonifying slope of head rotation x
Avatar.addSynth(\headqx, {
	var qx, trig;
	qx = ~leftUpperArmqx.avatarIn.lag(1.5);
	qx = Slope.kr(qx).abs;
	trig = Trig1.kr(qx > 0.5) * 0.01;
	SinOsc.ar(400, 0, Decay2.kr(trig) * 0.5).dup;
});
//:add a sound sonifying slope of all joint variables individually
Avatar.loadNamed(\speed_contrast).valuesGui.sendToGodot.play;
//:Debugging
Avatar.addSynth(\slopecluster161, {
	var jvar, src, qx;
	jvar = Avatar.controller.ioArray.reverse.first;
	qx = jvar.avatarIn.lag(1.5);
	SinOsc.ar(400, 0, 0.1).dup;
	/*
	collect: { | j, i |
		var qx, trig, freq;
		freq = i.linlin(0, 160, 100, 2000);
		qx = j.avatarIn.lag(1.5);
		qx = Slope.kr(qx).abs;
		trig = Trig1.kr(qx > 0.5) * 0.01;
		SinOsc.ar(freq, 0, Decay2.kr(trig) * 0.03).dup;
	};
	Mix(src).dup;
	*/
});

//:
Avatar.addSynth(\slopecluster161, {
	var src;
	src = Avatar.controller.ioArray.reverse collect: { | j, i |
		var qx, trig, freq;
		freq = i.linlin(0, 160, 100, 2000);
		qx = j.avatarIn.lag(1.5);
		qx = Slope.kr(qx).abs;
		trig = Trig1.kr(qx > 0.5) * 0.01;
		SinOsc.ar(freq, 0, Decay2.kr(trig) * 0.03).dup;
	};
	Mix(src).dup;
});
//
//:add a sound sonifying slope of each joint's variables
Avatar.loadNamed(\speed_contrast).valuesGui.sendToGodot.play; // restart if needed
//:
Avatar.loadNamed(\fidgety_introvert).valuesGui.sendToGodot.play; // try a different sequence
//:
Avatar.addSynth(\slopecluster23, {
	var src;
	src = Avatar.controller.ioArray.reverse.clump(7) collect: { | jg, i |
		var freq, slopeSum, trig;
		freq = (i * 5 + 40).midicps;
		slopeSum = Mix(jg collect: { | j |
			Slope.kr(j.avatarIn.lag(1.5)).abs;
		});
		trig = Trig1.kr(slopeSum > 0.5) * 0.01;
		SinOsc.ar(freq, 0, Decay2.kr(trig) * 0.03);
	};
	Mix(src);
});
//:
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
//:

//:
Avatar.loadNamed(\fidgety_introvert).valuesGui.sendToGodot.play;

Avatar.removeSynths;
Avatar.allSessionNames;
Avatar.stop;
Avatar.play;
Avatar.pause;
Avatar.resume;
Avatar.controller.ioArray collect: _.joint;