// 木 26  6 2025 16:38
// Redo of NamedSingleton

NamedInstance {
	classvar all;

	var <>name;

	*all { ^all ?? { all = MultiLevelIdentityDictionary() } }

	*doesNotUnderstand { | selector ... args |
		^this.default.perform(selector, *args);
	}

	*default { ^this.new(\default); }

	*new { | name = \default ... args | ^this.named(name, args) }

	*named { | name, args |
		var instance;
		instance = this.all.at(this, name);
		instance ?? {
			instance = this.newCopyArgs(name).init(*args);
			all.put(this, name, instance);
		};
		^instance;
	}

	// subclasses add their own code to init
	init {  }
	printOn { | stream |
		if (stream.atLimit) { ^this };
		stream << this.class.name << "<" ;
		stream << name.asString;
		stream << ">" ;
	}

	enableOsc { OscControl.addListener(this, name) }
	disableOsc { OscControl.removeListener(this, name) }

	makeDefault { this.all[\default] = this }
}