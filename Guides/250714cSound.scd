// 月 14  7 2025 11:25
// Controling sound through animation
// 0 Reminder: Boot the server before starting the session:
Server.default.reboot;

// 1. Start animation and gui, send to Godot
Avatar.valuesGui.sendToGodot.play;

// 2. Start a sound controlled by hip z variable value
// store it in \sndtest
Avatar.addSynth(\sndtest, { SinOsc.ar(~hipz.avatarIn.linlin(-2, 2, 400, 4000)) * 0.1});
// 3. Stop the sound stored in \sndtest
Avatar.removeSynth(\sndtest);

// 4. Start a synth with many sounds following different variables
//:
(
Avatar.addSynth(\sndtest, {
	Mix(
		[~hipx, ~hipy] collect: { | joint |
			SinOsc.ar(joint.avatarIn.linlin(-2, 2, 400, 4000))
		}
	).dup * 0.01;
})
)

//: 5. Sonify all joint variables, each with a Sine.
(
Avatar.addSynth(\sndtest, {
	var b, n, i, src;
	b = Avatar.controller.animbus;
	n = b.numChannels;
	i = b.index;
	src = (i .. i + (n - 1)) collect: { | c |
		SinOsc.ar(In.kr(c).linlin(-2, 2, 400, 4000))
	};
	Mix(src).dup * 0.5 / src.size;
});
)
//:
Avatar.removeSynth(\sndtest);
