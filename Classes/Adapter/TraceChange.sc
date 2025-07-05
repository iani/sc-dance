// 日 29  6 2025 15:00
// Post change messages emitted from any object

SimpleTrace {
	*update { | ... args |
		args.postln;
	}
}

+ Object {
	doTrace { this.simpleTrace(true) }
	dontTrace { this.simpleTrace(false) }
	simpleTrace { | add = true |
		if (add) {
			this.addDependant(SimpleTrace);
		}{
			this.removeDependant(SimpleTrace);
		}
	}

	simpleUntrace {
		this.removeDependant(SimpleTrace);
	}
}
