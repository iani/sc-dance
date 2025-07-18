
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
// shorter forms:
Avatar.setSynth(\hipy, { SinOsc.kr(0.3) / 3 + 1.25 });
Avatar.setSynth(\rightLegqz, { SinOsc.kr(0.3) });
Avatar.setSynth(\leftLegqx, { SinOsc.kr(0.5) / 4 });
//Remove all synth filters
Avatar.removeSynths;

//Add synth filter
Avatar.jointNames