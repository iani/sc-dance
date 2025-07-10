//: 日  6  7 2025 13:23
//TODO:
(
// Define a noisy synth to be modulated
Ndef(\noisy, {
    var sig;
    // A control signal generating 5 new values per second
    // from the "Entropic Gap" algorithm.
    var freq = SurrealGenerator.kr(
        algorithm: 11,
        steps: 1500,
        freq: 15,
        min: 200,
        max: 2000,
        curve: \exp
    );
    sig = Saw.ar([freq, freq+0.1]);
    // Apply the modulation to a low-pass filter
    sig = RLPF.ar(sig, 1000, 0.1);
    Pan2.ar(sig, 0, 0.1);
}).play;