// 日 29  6 2025 15:00
// Post change messages emitted from any object

SimpleTrace {
	*update { | ... args |
		args.postln;
	}
}

+ Object {
	simpleTrace {
		this.addDependant(SimpleTrace);
	}

	simpleUntrace {
		this.removeDependant(SimpleTrace);
	}
}
