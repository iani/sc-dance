// 月 21  7 2025 19:18

Avatar.valuesGui;
Avatar.sendToGodot;
Avatar.play;
Avatar.stop;
//:
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftShoulderslope, {
	var mul, val;
	#mul, val = ~leftShoulder.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \cricket_taps.buffer, BufRateScale.kr(\cricket_ff.buffer)
		* val, 1, 0, 1) * mul * 0.3;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftUpperArmslope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \echo_crickets.buffer, BufRateScale.kr(\echo_crickets.buffer)
		* val, 1, 0, 1) * mul * 0.3;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftLowerArmslope, {
	var mul, val;
	#mul, val = ~leftLowerArm.slopePhrase(map1: 0.5, map2: 2);
	PlayBuf.ar(1, \fones.buffer, BufRateScale.kr(\fones.buffer) * val, 1, 0, 1)
	* mul * 0.3;
});

//:Tweak \leftLowerArmslope to make freq curve smoother
Avatar.setSynthCtl(\leftLowerArmslope, \ampLag, 2);

//: Tweak again - by adding lag inside the synthfunc
Avatar.addSynth(\leftLowerArmslope, {
	var mul, val;
	#mul, val = ~leftLowerArm.slopePhrase(map1: 1.5, map2: 2);
	PlayBuf.ar(1, \fones.buffer,
		BufRateScale.kr(\fones.buffer) * val.lag(2), 1, 0, 1) * mul * 0.3;
});

//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftHandslope, {
	var mul, val;
	#mul, val = ~leftHand.slopePhrase(map1: 2.5, map2: 15);
	PlayBuf.ar(1, \hanbaiki.buffer, BufRateScale.kr(\hanbaiki.buffer) * val,
		1, 0, 1) * mul.lag(2) * 0.3;
});

//: rightUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightShoulderslope, {
	var mul, val;
	#mul, val = ~rightShoulder.slopePhrase(map1: 0.15, map2: 0.2);
	PlayBuf.ar(1, \cricket_taps.buffer, BufRateScale.kr(\cricket_ff.buffer)
		* val, 1, 0, 1) * mul * 0.3;
});

//: rightUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightUpperArmslope, {
	var mul, val;
	#mul, val = ~rightUpperArm.slopePhrase(map1: 0.15, map2: 0.2);
	PlayBuf.ar(1, \echo_crickets.buffer, BufRateScale.kr(\echo_crickets.buffer)
		* val, 1, 0, 1) * mul * 0.3;
});

//: rightUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightLowerArmslope, {
	var mul, val;
	#mul, val = ~rightLowerArm.slopePhrase(map1: 0.15, map2: 20);
	PlayBuf.ar(1, \fones.buffer, BufRateScale.kr(\fones.buffer) * val, 1, 0, 1)
	* mul.lag(1) * 0.2;
});

//:Tweak \rightLowerArmslope to make freq curve smoother
Avatar.setSynthCtl(\rightLowerArmslope, \ampLag, 2);

//: Tweak again - by adding lag inside the synthfunc
Avatar.addSynth(\rightLowerArmslope, {
	var mul, val;
	#mul, val = ~rightLowerArm.slopePhrase(map1: 0.15, map2: 0.2);
	PlayBuf.ar(1, \fones.buffer,
		BufRateScale.kr(\fones.buffer) * val.lag(2), 1, 0, 1) * mul * 0.2;
});

//: rightUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightHandslope, {
	var mul, val;
	#mul, val = ~rightHand.slopePhrase(map1: 0.15, map2: 0.5);
	PlayBuf.ar(1, \hanbaiki.buffer, BufRateScale.kr(\hanbaiki.buffer) * val,
		1, 0, 1) * mul.lag(2) * 0.1;
});
//:
Avatar.removeSynth(\rightHandslope);
Avatar.removeSynth(\leftHandslope);
Avatar.removeSynth(\rightLowerArmslope);
Avatar.removeSynth(\hipslope);
Avatar.removeSynth(\headslope);
Avatar.removeSynth(\neckslope);

Avatar.removeSynth(\chestsclope);

Avatar.removeSynths;

Server.default.stopRecording;
