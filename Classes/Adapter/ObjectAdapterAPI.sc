// 土  5  7 2025 08:08
// Adapted from sc-hacks-redux

/* 30 Jan 2021 12:25
Transferred from sc-hacks.
*/

+ Object {
	addAdapter { | notifier, message, action |
		Adapter(notifier, message, this, action).add;
	}

	removeAdapter { | notifier, message |
		Adapter.remove(notifier, message, this);
	}

	addAdapterOneShot { | notifier, message, action |
		this.addAdapter(notifier, message, { | notification ... args |
			action.(notification, *args);
			this.removeAdapter(notifier, message);
		})
	}

	allListeners { ^Adapter.listenersOf(this) }
	allNotifiers { ^Adapter.notifiersOf(this) }

	objectClosed {
		this.changed(\objectClosed);
		this.removeAllListeners;
		this.removeAdapters;
		this.releaseDependants;
	}

	removeAllListeners { Adapter removeListenersOf: this }
	removeAdapters { Adapter removeAdaptersOf: this }

	onObjectClosed { | listener, action |
		listener.addAdapter(this, \objectClosed, action);
		if (this respondsTo: \onClose_) {
			this.onClose = { this.objectClosed };
		}
	}

	addNodeActions { | node, onStart, onEnd |
		node.onStart({ onStart.(this, node) }, this);
		node.onEnd({ onEnd.(this, node) }, this);
	}
	// TODO:
	// removeListenersAt { | message | }
	// removeAdaptersAt { | message | }

}

+ Node {
    /* always release notified nodes when they are freed
        Note: any objects that want to be notified of the node's end,
        can listen to it notifying 'n_end', which is triggered through NodeWatcher
        and which is the same message that makes the Node remove all its Adapters.
    */
	// Fixed  6 Dec 2022 17:55 - still needs watching and more testing
    addAdapter { | notifier, message, action |
        super.addAdapter(notifier, message, action);
        NodeWatcher.register(this);
		this.addDependant({ | me, message |
			// args.postln;
			// "somethingChanged".postln;
			if (message == 'n_end') {
				// "I ended".postln;
				{ this.objectClosed; }.defer(0.1);
			}
		});
		//     this.addAdapterOneShot(this, 'n_end', {
		// 		// remove notifiers only after all notifications have been issued!
		// 		// { this.objectClosed; }.defer(0.1);
		// 		// "debuggging node addAdapter".postln;
		// });
	}

	doOnStart { | action, listener |
		if (this.isPlaying) { ^action.(this) };
		listener = listener ? { this }; // DO NOT CHANGE THIS!
		NodeWatcher.register(this);
		listener.addAdapterOneShot(this, \n_go, {
			this.isPlaying = true;
			action.(this);
			// this.changed(\started);
		});
	}

	doOnEnd { | action, listener |
		listener = listener ? { this }; // DO NOT CHANGE THIS!
		NodeWatcher.register(this);
		listener.addAdapterOneShot(this, \n_end, { action.(this) });
	}
}
