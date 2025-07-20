//: Load, connect to GODOT and start animation
Avatar.load.valuesGui.sendToGodot.play;
// ----------- Trying all 21 Joints with slope -----------
//:post jointNames:
Avatar.jointNames.clump(5) do: _.postln;
Avatar.removeSynths;
//:Do each joint in turn:
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\hipslope, {
	var mul, val;
	#mul, val = ~hip.slopePhrase(map1: 200, map2: 400);
	SinOsc.ar(val).dup * mul * 0.1;
});
//:
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\spineslope, {
	var mul, val;
	#mul, val = ~spine.slopePhrase(map1: 400, map2: 800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\chestslope, {
	var mul, val;
	#mul, val = ~chest.slopePhrase(map1: 180, map2: 100);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\neckslope, {
	var mul, val;
	#mul, val = ~neck.slopePhrase(map1: 1200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\headslope, {
	var mul, val;
	#mul, val = ~head.slopePhrase(map1: 1200, map2: 1000);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftShoulderslope, {
	var mul, val;
	#mul, val = ~leftShoulder.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftUpperArmslope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 1800, map2: 1200);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftLowerArmslope, {
	var mul, val;
	#mul, val = ~leftLowerArm.slopePhrase(map1: 300, map2: 180);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftHandslope, {
	var mul, val;
	#mul, val = ~leftHand.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightShoulder, {
	var mul, val;
	#mul, val = ~rightShoulder.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightUpperArmslope, {
	var mul, val;
	#mul, val = ~rightUpperArm.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightLowerArmslope, {
	var mul, val;
	#mul, val = ~rightLowerArm.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightHandslope, {
	var mul, val;
	#mul, val = ~rightHand.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftUpLegslope, {
	var mul, val;
	#mul, val = ~leftUpLeg.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftLegslope, {
	var mul, val;
	#mul, val = ~leftLeg.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftFoot.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftFoot.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftToeslope, {
	var mul, val;
	#mul, val = ~leftToe.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftToeEndslope, {
	var mul, val;
	#mul, val = ~leftToeEnd.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightUpLegslope, {
	var mul, val;
	#mul, val = ~rightUpLeg.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightLegslope, {
	var mul, val;
	#mul, val = ~rightLeg.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightFootslope, {
	var mul, val;
	#mul, val = ~rightFoot.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightToeslope, {
	var mul, val;
	#mul, val = ~rightToe.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
-//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\rightToeEndslope, {
	var mul, val;
	#mul, val = ~rightToeEnd.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
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
	#mul, val = ~leftUpperArm.slopePhrase;
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 400, map2: 800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\slope, {
	var mul, val;
	#mul, val = ~leftUpperArm.slopePhrase(map1: 200, map2: 1800);
	SinOsc.ar(val).dup * mul * 0.1;
});
//:
Avatar.removeSynths;
Avatar.jointNames;