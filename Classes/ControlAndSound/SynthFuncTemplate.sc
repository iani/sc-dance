// 月 21  7 2025 00:42
// Prototype for function used inside a Synth Function
// Define subclasses with names reflecting the Synth Func's purpose/contents.

SynthFuncTemplate {
	*ar {
		^{ Silent.ar }
	}
}

// Example:

SinTest : SynthFuncTemplate {
	*ar { | freq |
		^{ SinOsc.ar(freq, 0, 0.1).dup }
	}
}