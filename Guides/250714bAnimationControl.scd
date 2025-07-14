// 月 14  7 2025 10:25
// Control the animation with functions and synths

// 1. Start a gui and animation and connect to godot:
Avatar.valuesGui.play.sendToGodot;

//: 2. Filter: Make hip y position follow the values of the control bus
Avatar.addFilterc(\hipy);

//: 3. Set the value of control of hip y.
Avatar.setctl(\hipy, 2);

//: 4. Try different values at random
// (Run the next line several times.)

Avatar.setctl(\hipy, -1.0 rrand: 2.0);

//: 5. Remove the control filter from hip y position
Avatar.removeFilter(\hipy);

//: 6. Control a joint with a synth

Avatar.addFilterc(\hipy); // remember to add back the control filter
Avatar.addSynth(\test, { ~hipy.out(SinOsc.kr(1/5) + 1) });

//: 7. Control another joint with a synth
Avatar.addFilterc(\chestqw); // remember to add back the control filter
Avatar.addSynth(\chest, { ~chestqw.out(SinOsc.kr(1) * 0.5) });

//: 8. Remove all filters.
Avatar.removeFilters;