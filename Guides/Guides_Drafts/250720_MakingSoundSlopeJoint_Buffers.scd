var bufferNames = #['columbia', 'cricket_ff', 'cricket_taps', 'crickets', 'crossing', 'default', 'echo_crickets', 'fones', 'hanbaiki', 'kiiroi', 'nami', 'namishort', 'takikoorogi', 'takisuiryu', 'takunia', 'weddellpock', 'wind'];

//: Load, connect to GODOT and start animation
Avatar.load.valuesGui.sendToGodot.play;

//: ----------- Trying all 21 Joints with slope -----------

//:post jointNames:
Avatar.jointNames.clump(5) do: _.postln;
Avatar.jointNames.asCompileString;
ScDanceAssets.buffers.keys.asArray.sort.asCompileString;

//:
Avatar.removeSynths;
//:Do each joint in turn:

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\hipslope, {
	var mul, val;
	#mul, val = ~hip.slopePhrase(lothresh: 0.5, map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crossing.buffer, BufRateScale.kr(\crossing.buffer) * val, 1, 0, 1) * mul * 0.1;
});
//:make hipslope more sensitive to slope - since hip is less agile than hands
Avatar.setSynthCtl(\hipslope, \lothresh, 0.4);
//: more silence
Avatar.setSynthCtl(\hipslope, \lothresh, 1.0);
//: less silence
Avatar.setSynthCtl(\hipslope, \lothresh, 0.1);
//:

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\spineslope, {
	var mul, val;
	#mul, val = ~spine.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_ff.buffer, BufRateScale.kr(\cricket_ff.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\chestslope, {
	var mul, val;
	#mul, val = ~chest.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_taps.buffer, BufRateScale.kr(\cricket_taps.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\neckslope, {
	var mul, val;
	#mul, val = ~neck.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crickets.buffer, BufRateScale.kr(\crickets.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\headslope, {
	var mul, val;
	#mul, val = ~head.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crossing.buffer, BufRateScale.kr(\crossing.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftShoulderslope, {
	var mul, val;
	#mul, val = ~leftShoulder.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_taps.buffer, BufRateScale.kr(\cricket_ff.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftUpperArmslope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \echo_crickets.buffer, BufRateScale.kr(\echo_crickets.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftLowerArmslope, {
	var mul, val;
	#mul, val = ~leftLowerArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \fones.buffer, BufRateScale.kr(\fones.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//:Tweak \leftLowerArmslope to make freq curve smoother
Avatar.setSynthCtl(\leftLowerArmslope, \ampLag, 2);

//: Tweak again - by adding lag inside the synthfunc
Avatar.addSynth(\leftLowerArmslope, {
	var mul, val;
	#mul, val = ~leftLowerArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \fones.buffer,
		BufRateScale.kr(\fones.buffer) * val.lag(2), 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftHandslope, {
	var mul, val;
	#mul, val = ~leftHand.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \hanbaiki.buffer, BufRateScale.kr(\hanbaiki.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightShoulder, {
	var mul, val;
	#mul, val = ~rightShoulder.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \kiiroi.buffer, BufRateScale.kr(\kiiroi.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightUpperArmslope, {
	var mul, val;
	#mul, val = ~rightUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \nami.buffer, BufRateScale.kr(\nami.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightLowerArmslope, {
	var mul, val;
	#mul, val = ~rightLowerArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \namishort.buffer, BufRateScale.kr(\namishort.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightHandslope, {
	var mul, val;
	#mul, val = ~rightHand.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \takikoorogi.buffer, BufRateScale.kr(\takikoorogi.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftUpLegslope, {
	var mul, val;
	#mul, val = ~leftUpLeg.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \takisuiryu.buffer, BufRateScale.kr(\takisuiryu.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftLegslope, {
	var mul, val;
	#mul, val = ~leftLeg.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \takunia.buffer, BufRateScale.kr(\takunia.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftFoot.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \weddellpock.buffer, BufRateScale.kr(\weddellpock.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftFoot.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \wind.buffer, BufRateScale.kr(\wind.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftToeslope, {
	var mul, val;
	#mul, val = ~leftToe.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crossing.buffer, BufRateScale.kr(\crossing.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftToeEndslope, {
	var mul, val;
	#mul, val = ~leftToeEnd.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_ff.buffer, BufRateScale.kr(\cricket_ff.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightUpLegslope, {
	var mul, val;
	#mul, val = ~rightUpLeg.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_taps.buffer, BufRateScale.kr(\cricket_taps.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightLegslope, {
	var mul, val;
	#mul, val = ~rightLeg.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crickets.buffer, BufRateScale.kr(\crickets.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightFootslope, {
	var mul, val;
	#mul, val = ~rightFoot.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \crossing.buffer, BufRateScale.kr(\crossing.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightToeslope, {
	var mul, val;
	#mul, val = ~rightToe.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_ff.buffer, BufRateScale.kr(\cricket_ff.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightToeEndslope, {
	var mul, val;
	#mul, val = ~rightToeEnd.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \echo_crickets.buffer, BufRateScale.kr(\echo_crickets.buffer) * val, 1, 0, 1) * mul * 0.1;
});


//------------------------------------------------------------
//
//:Preliminary runs:
Avatar.addSynth(\slope, {
	var slope;
	slope = ~leftUpperArm.slope;
	SinOsc.ar(slope.linlin(0, 3, 1000, 200)).dup * 0.1 *
	(slope > 2).lag(1.5) * (slope < 3).lag(0.1) * slope;
});

//: leftUpperArm - using slopePhrase
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \fones.buffer, BufRateScale.kr(\fones.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \hanbaiki.buffer, BufRateScale.kr(\hanbaiki.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \kiiroi.buffer, BufRateScale.kr(\kiiroi.buffer) * val, 1, 0, 1) * mul * 0.1;
});

//:
Avatar.removeSynths;
Avatar.jointNames;