// PlayBufTemplateTest.scd
// Example of using PlayBufTemplate with Avatar.addSynth

//: Load, connect to GODOT and start animation
Avatar.load.valuesGui.sendToGodot.play;

//: Define buffer names (for convenience, assuming they are loaded)
var bufferNames = #['columbia', 'cricket_ff', 'cricket_taps', 'crickets', 'crossing', 'default', 'echo_crickets', 'fones', 'hanbaiki', 'kiiroi', 'nami', 'namishort', 'takikoorogi', 'takisuiryu', 'takunia', 'weddellpock', 'wind'];

//: Example using PlayBufTemplate
Avatar.addSynth(\hipslope, {
	var mul, val;
	#mul, val = ~hip.slopePhrase(map1: 0.5, map2: 2);
	PlayBufTemplate.ar(\crickets, val) * mul * 0.1;
});
//:
Avatar.setSynthCtl(\hipslope, \lothresh, 0.5);
Avatar.setSynthCtl(\hipslope, \hithresh, 1.0);
//: Cleanup
// Avatar.removeSynths;
// Avatar.jointNames;