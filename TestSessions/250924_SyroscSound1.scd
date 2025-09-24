// 月 21  7 2025 19:18

//: Load, connect to GODOT and start animation

Avatar.valuesGui;
Avatar.sendToGodot;
Avatar.play;

Avatar.removeSynths;
//:Do each joint in turn:
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\hipslope, {
	var mul, val;
	#mul, val = ~hip.slopePhrase(map1: 50, map2: 200, lothresh: 0.4);
	SinOsc.ar(val).dup * mul * 0.05;
});
//:
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\spineslope, {
	var mul, val;
	#mul, val = ~spine.slopePhrase(map1: 800, map2: 400, lothresh: 0.4);
	SinOsc.ar(val).dup * mul * 0.05;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\chestslope, {
	var mul, val;
	#mul, val = ~chest.slopePhrase(map1: 180, map2: 100,  lothresh: 0.4);
	SinOsc.ar(val).dup * mul * 0.05;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\neckslope, {
	var mul, val;
	#mul, val = ~neck.slopePhrase(map1: 600, map2: 800, lothresh: 0.4);
	SinOsc.ar(val).dup * mul * 0.05;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\headslope, {
	var mul, val;
	#mul, val = ~head.slopePhrase(map1: 1000, map2: 1800, lothresh: 0.3);
	SinOsc.ar(val).dup * mul * 0.05;
});
//: leftUpperArm - using slopePhrase with different mapping
Avatar.addSynth(\leftShoulderslope, {
	var mul, val;
	#mul, val = ~leftShoulder.slopePhrase(map1: 1200, map2: 2100, lothresh: 0.3);
	SinOsc.ar(val).dup * mul * 0.05;
});
//:

Avatar.removeSynth(\hipslope);
Avatar.removeSynth(\spineslope);
Avatar.removeSynth(\chestslope);
Avatar.removeSynth(\leftShoulderslope);
Avatar.removeSynth(\headslope);
Avatar.removeSynth(\neckslope);
Avatar.removeSynth(\leftShoulderslope);