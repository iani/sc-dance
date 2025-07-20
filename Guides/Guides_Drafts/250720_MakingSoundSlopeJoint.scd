//: Load, connect to GODOT and start animation
Avatar.load.valuesGui.sendToGodot.play;
//:Test a sound without control.
//:Trying all 21 Joints with slope
Avatar.addSynth(\slope, {
	var slope;
	slope = ~leftUpperArm.slope;
	SinOsc.ar(slope.linlin(0, 3, 1000, 200)).dup * 0.1 *
	(slope > 2).lag(1.5) * (slope < 3).lag(0.1) * slope;
});
//:Get control values from left arm
Avatar.addSynth(\test1, {
	SinOsc.ar(
		~leftUpperArmqy.ain(200, 2000)
	).dup * 0.1
});
//:Get control values from left upper leg
Avatar.addSynth(\test2, {
	SinOsc.ar(
		~leftUpLegqx.ain(100, 1000)
	).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test3, {
	SinOsc.ar(
		~leftUpLegqy.avatarIn(100, 1000)
	).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test3, {
	var in;
	in = Slope.kr(~leftUpLegqy.avatarIn.lag(1));
	SinOsc.ar(
		in.abs.linlin(0, 10, 200, 1000)
	).dup * 0.1
});
//:Add control values of left upper leg
//Try 1: !!!!!!!!! Use this one to code sumSlope in Joint class
Avatar.addSynth(\test3, {
	var in;
	in = Slope.kr(~leftUpLegqy.avatarIn.lag(1));
	SinOsc.ar(
		in.abs.linlin(0, 10, 200, 1000)
	).dup * 0.1
});
//:
Avatar.removeSynths;
//:Add control values of left upper leg
//Try 2: !!!!!!!!! Use this one to code sumSlope in Joint class
Avatar.addSynth(\test3, {
	var in;
	in = ~rightUpperArm.vars collect: { | v |
		Slope.kr(v.avatarIn.lag(1)).abs.lag(1)
	};
	SinOsc.ar(
		Mix(in).linlin(0, 10, 200, 1000)
	).dup * 0.1
});
//:Try 3: !!!!! Testing the algorithm as coded in sumSlope
Avatar.addSynth(\test4, {
	SinOsc.ar(
		~leftUpLeg.sumSlope.linlin(0, 10, 200, 2000)
	).dup * 0.1
});
//:Try 3: !!!!! Using sumSlope as trigger
Avatar.addSynth(\test5, {
	var slope, trig;
	slope = ~leftUpperArm.sumSlope;
	trig = Trig1.kr(slope > 0.5);
	SinOsc.ar(400)
	* Decay2.kr(trig)
	* 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test4, {
	SinOsc.ar(
		~leftUpLeg.sumSlope.linlin(0, 10, 200, 2000)
	).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.vars collect: _.ain;
	src = SinOsc.ar(src.linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.vars collect: _.ain;
	src = SinOsc.ar(src.linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.vars collect: _.ain;
	src = SinOsc.ar(Amplitude.kr(src).linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.vars collect: _.ain;
	src = SinOsc.ar(Slope.kr(Amplitude.kr(src)).linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.vars collect: _.ain;
	src = SinOsc.ar(Amplitude.kr(src).linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:Add control values of left upper leg
Avatar.addSynth(\test5, {
	var src;
	src = ~leftHand.sumSlope;
	src = SinOsc.ar(src.linlin(-2, 2, 400, 2000));
	Mix(src).dup * 0.1
});
//:
Avatar.removeSynths;
Avatar.jointNames;