
Avatar.valuesGui;
Avatar.play;

Avatar.addLocalGodot;

Avatar.setctl(\hipy, 1);
Avatar.removectl(\hipy);

Avatar.setctl(\spineqx, 1);
Avatar.removectl(\hipy);

Avatar.addFilterc(\hipy);
Avatar.addSynth(\hipy, { ~hipy.out(SinOsc.kr(0.2) + 1) });
Avatar.removeSynth(\hipy);
Avatar.addSynth(\hipz, { ~hipz.out(SinOsc.kr(0.2) + 1) });

Avatar.addSynth(\spineqy, { ~spineqy.out(SinOsc.kr(2) * 2) });
Avatar.
//:
Avatar.addSynth(\sndtest, { SinOsc.ar(~hipz.rin.linlin(-2, 2, 400, 4000)) * 0.1});
Avatar.addSynth(\sndtest2, { LFPulse.ar(~hipqy.rin.linlin(-2, 2, 100, 400)) * 0.01});
Avatar.removeSynth(\sndtest);
Avatar.removeSynth(\sndtest2);

//:

//: