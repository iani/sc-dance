// 土  5  7 2025 17:01
// Remove all adapters from views when their window closes
//
//From sc-hacks-redux. TODO:
//
//:
/*
	objectClosed {
		this.changed(\objectClosed);
		this.removeListeners;
		this.removeNotifiers;
		this.releaseDependants;
	}

	removeListeners { Notification removeListenersOf: this }
	removeNotifiers { Notification removeNotifiersOf: this }

	onObjectClosed { | listener, action |
		listener.addNotifier(this, \objectClosed, action);
		if (this respondsTo: \onClose_) {
			this.onClose = { this.objectClosed };
		}
	}

*/
