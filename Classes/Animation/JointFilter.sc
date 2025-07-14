// 土  5  7 2025 06:22
// Hold a function and a cached value.
// In response to message \filter, return the result of
// evaluating the function, with arguments:
// argument 1: The first argument passed to \value
// argument 2: a value cached in variable val
// Receiver nil returns the first argument.

// For use with RokokoFilter
// Details:
// Make nil return the input, and non-nil function return the
// result of evaluating the function with input as single argument.
// For usage, see RokokoFilter implementation.
// Example: simple evaluation (\value), returns nil when receiver is nil:
// f = { | input | input }.asFilter;
// f.(1) // if f is above function, value (.) returns the input
// g.(1) // if g is nil, it returns nil
// f.filter(1); // function f.filter returns the input
// g.filter(1); // nil.filter also returns the input

JointFilter {
	var <>func, <>controls, <>index = 0, <joint;

	*new { | func, controls, index, joint |
		^this.newCopyArgs(func, controls, index, joint);
	}

	filter { | input |
		if (index.isNil) {
			^func.(input, 0);
		}{
			^func.(input, controls[index] ? 0);
		}
	}
}

+ Nil {
	filter { | input | ^input }
	asFilter { ^this }
}

+ Array {
	// filter each element of input through the filter functions of myself
	filter { | input |
		^input collect: { | item, index |
			this[index].filter(item);
		}
	}
}

+ Function {
	asFilter { | val |
		^ValueAdapter(this, val);
	}
}

// Early prototype
/*
ValueAdapter {
	var <>func, val;
	*new { | func, val |
		^this.newCopyArgs(func, val);
	}

	filter { | input |
		^func.(input);
	}

	asFilter { ^this }
}
*/