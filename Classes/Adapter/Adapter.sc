// 土  5  7 2025 05:23
// (Rename from sc-hacks-redux: Notification)
// React to \changed messages emitted by an object via the sandard dependant mechanism
// React when an object runs changed, for example:
// anObbject.changed(\sspect ... args);
// In response to this any other object can perform a specified action.

// This works as follows:
//
// Let us call the object that performs changed a "notifier"
// and the object that reacts to that change a "listener".
// Let us call
// We thus have the following items involved in the whole pattern:
// 1. The notifier:
// 2. The listener:
// 3. The aspect changed:
// 4. The extra arguments passed to the changed method
// 5. The function performed
// The mechanism runs as follows:
// The notifier performs notifier.changed(aspect ... args);
// In response, the
//
// Why so many parts?
// This pattern involves 5 different parts. This is complex to
// get used to. However it affords maximum flexibility and covers
// a very wide range of usage cases.
// - Any object can ....
// ...
// ... TODO: Write up more!

Adapter {
	classvar <controllers;

	var <notifier, <message, <listener, <action;

	*initClass { controllers = IdentityDictionary(); }

	*new { | notifier, message, listener, action |
		^super.newCopyArgs(notifier, message, listener, action);
	}

	update { | sender, argMessage ... args |
		 action.valueArray(this, *args)
	}

	add {
		var controller;
		controller = controllers[notifier];
		controller ?? {
			controller = AdapterController(notifier);
			controllers[notifier] = controller;
		};
		controller.add(message, listener, this);
	}

	*get { | notifier, message, listener |
		^controllers.at(notifier).at(message, listener);
	}

	remove { this.class.remove(notifier, message, listener); }

	*remove { | argNotifier, message, listener |
		controllers[argNotifier].remove(message, listener);
	}

	*clear { this.notifications do: _.remove }

	*notifications { ^controllers.values.collect({|nc|nc.actions.values}).flat; }

	*listeningto { | notifier |
		^this.notifications.select({ | n | n.notifier === notifier })
	}

	*notifying { | listener |
		^this.notifications.select({ | n | n.listener === listener })
	}

	*removeNotifiersOf { | listener |
		this.notifying(listener) do: _.remove;
	}

	*removeListenersOf { | notifier |
		this.listeningto(notifier) do: _.remove;
	}

	*notifiers {
		^Set.newFrom(this.notifications.collect({|n| n.notifier})); //.asArray;
	}
	*listeners {
		^Set.newFrom(this.notifications.collect({|n| n.listener})); //.asArray;
	}
	// *listeners { ^controllers.collect({ | c | c.listeners }).asArray.flat; }

	*matches { | notifier, listener, message |
		^this.notifications.detect({|n| n.matches(notifier, listener, message)}).notNil
	}

	matches { | argNotifier, argListener, argMessage |
		^notifier == argNotifier and:
		{ listener == argListener } and:
		{ message == argMessage }
	}

	// ---- rarely used access methods ----
	*notifiersOf { | listener |
		^Set newFrom:
		(this.notifications.select({|n| n.listener === listener }) ?? [])
		.collect(_.notifier);
	}

	*messagesOf { | notifier |
		var controller;
		controller = controllers[notifier];
		if (controller.isNil) { ^nil } { ^controller.messages };
	}

	*listenersOf { | notifier |
		^Set newFrom:
		(this.notifications.select({|n| n.notifier === notifier }) ?? [])
		.collect(_.listener);
	}
}
