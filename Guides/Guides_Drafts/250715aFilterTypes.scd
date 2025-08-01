//火 15  7 2025 07:45
//1. Preparation
// To start, load and play a session
Avatar.loadNamed(\fidgety_introvert).sendToGodot.play;
// Pause in order to see the effect of filters more clearly
Avatar.pause; // stop playback
Avatar.resume; // resume playback from the last paused frame
Avatar.play; // restart from the beginning
Avatar.stop; // Stop playing the avatar
//2. Changing a joint value with filters.
//A filter modifies a slot in the message array before sending.
//The function of the filter returns the value for that slot.
//hip qx rotates the hip along the transverse horizontal axis
Avatar.addFilter(\hipqx, 1); // set joint to a fixed value;
Avatar.addFilter(\hipqx, 0);
Avatar.addFilter(\hipqx, -1);
Avatar.addFilter(\hipqy, 0); // set joint to a fixed value;
Avatar.addFilter(\hipqz, 0); // set joint to a fixed value;
Avatar.removeFilter(\hipqx); // remove joint modifier
Avatar.removeFilters(\hipqx, \hipqz); // remove several modifiers
//3. Using synths to modify joints continuously:
Avatar.pause; // stop playback
Avatar.addCopySynth(\hipqy, { SinOsc.kr(0.2) / 2 }); // rotate hip @ y axis
Avatar.addCopySynth(\hipqx, { SinOsc.kr(0.2) / 2 }); // rotate hip @ x axis
Avatar.addCopySynth(\hipqz, { SinOsc.kr(0.2) / 2 }); // rotate hip @ z axis
Avatar.addCopySynth(\hipqw, { SinOsc.kr(0.2) / 50 }); // rotate hip @ z axis

//:LFnoise0 has more freedom - like dance
Avatar.addCopySynth(\hipqx, { LFNoise1.kr(1) }); // rotate hip @ x axis
Avatar.addCopySynth(\hipqy, { LFNoise1.kr(1) }); // rotate hip @ x axis
Avatar.addCopySynth(\hipqz, { LFNoise1.kr(1) }); // rotate hip @ x axis
Avatar.resume; // resume playback from the last paused frame

Avatar.removeSynth(\hipqx);

Avatar.removeSynths; // remove several synths. if none are given, remove all

Avatar.removeFilters;

Avatar.pause;
//:
//:Set values in a loop - instead of synths:
fork {
	(1..200).normalize.mirror do: { | i |
		Avatar.addFilter(\hipqx, (i.postln * 2).postln);
		0.03.wait;
	};
	"DONE".postln;
}
//:Test all joints in a row - many joints have no effect
fork {
	Avatar.jointNames do: { | joint |
		postf("Testing joint: %\n", joint);
		(1..50).normalize(0, 1.0).mirror
		++ (1..50).normalize(0, -10).mirror do: { | val |
			Avatar.addFilter(joint, val);
			0.03.wait;
		};
		Avatar removeFilter: joint
	};
	"DONE".postln;
};
//:
Avatar.ctlNames;
//: Yoga hallucination
Avatar.ctlNames do: { | joint |
	Avatar.setSynth(joint, { LFNoise1.ar(0.1 rrand: 2.11) / 2  })
};
Avatar.setSynth(\hipy, { LFNoise0.ar(1).range(0.5, 2.01) });
//:To stop all synths and remove all filters:
//
Avatar.addFilter(\hipy, 2);
//:
Avatar.removeSynths;
//:To remove all filters without stopping the synths:
Avatar.removeFilters;

//:
//:Rotate:
~x = (1..1000).normalize(0, 4pi).sin.pseq.asStream;
~y = (1..1000).normalize(0, 4pi).sin.pseq.asStream;
~z = (1..1000).normalize(0, 4pi).sin.pseq.asStream;
~r = (0..10).normalize(0, 2pi).prand;
~r = 0;

Avatar.pause;
Avatar.resume;
Avatar.addFilter(\hipqx, { ~x.next });
Avatar.addFilter(\hipqy, { ~y.next });
Avatar.addFilter(\hipqz, { ~z.next });

Avatar.addFilter(\hipqy, { 0 });
Avatar.addFilter(\hipqy, { 0 rrand: 2pi });

Avatar.removeFilter(\hipy);
//There are 3 filter types:
//

(*)(1, 2);
Avatar.addSumFilter

(1..100).normalize.sin;;

Avatar.pause;

Avatar.animator.task.isPlaying;
Avatar.animator.task.pause;

Avatar.stop;
Avatar.play;

t = Avatar.controller.pollTask;
t.isPlaying;
t.isRunning;