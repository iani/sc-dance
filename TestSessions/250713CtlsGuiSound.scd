
Avatar.valuesGui.play;

Avatar.addSynth(\ctltest, { ~hipz.out(SinOsc.ar(0.1)) });
//:
Avatar.addSynth(\sndtest, { SinOsc.ar(~hipz.rin.linlin(-2, 2, 400, 4000)) * 0.1});
Avatar.addSynth(\sndtest2, { LFPulse.ar(~hipqy.rin.linlin(-2, 2, 100, 400)) * 0.01});
Avatar.deleteSynth(\sndtest);
Avatar.deleteSynth(\sndtest2);

//:

//: