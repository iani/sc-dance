//土  5  7 2025 14:32
//Manage windows for other objects.
//Allow an object to open any number of windows.
//Store windows in a dictionary, each window in
//a different key given by the user.
//When the window closes, remove it from the dictionary.
//When a window is open, asking to create it will bring the existing
//window instance to the front, and return it to the caller
//for further processing if needed.

Windows {
	classvar all;

	*initClass {
		all = MultiLevelIdentityDictionary();
	}

	*makeWindow { | owner, key = \default, initFunc |
		// initFunc only runs if a new window is created.
		var window;
		window = all.at(owner, key);
		if (window.isNil) {
			window = Window();
			window.onClose = { | me |
				// postln("This window closed:" + window);
				all.removeAt(owner, key);
			};
			initFunc.(window);
			all.put(owner, key, window);
		}{ // if window exists, bring it to front. Do not initialize it
			window.front;
		};
		^window;
	}

}