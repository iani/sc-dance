//土  5  7 2025 04:58
//Forward messages received from OSC to other addresses
+ NetAddr {
	forwardMsg { | msgName, filter, handler |
		OscControl.enable;
		if (this == NetAddr.localAddr) {
			"WARNING!".postln;
			"forwardMsg to local address is disabled to prevent loop-hangups".postln;
			"I will post messages instead of forwarding them to self".postln;
			this.addAdapter(OscControl, msgName.oscMessage, { | sender, message |
				message.postln;
			});
		}{
			// postln("Forwarding message" + msgName.oscMessage + "to" + this);
			this.addAdapter(OscControl, msgName.oscMessage, { | sender, message |
				// postln("Handler:" + handler);
				handler !? { handler.msgCache = message };
				this.sendMsg(*filter.filter(message));
			})
		}
	}

	unforwardMsg { | msgName, filter |
		this.removeAdapter(OscControl, msgName.oscMessage);
	}
}

+ Collection {
	forwardMsg { | msgName, filter, handler |
		var withoutLocalAddr;
		OscControl.enable;
		msgName = msgName.oscMessage;
		withoutLocalAddr = this reject: { | a | a == NetAddr.localAddr };
		if (withoutLocalAddr.size < this.size) {
			"WARNING:".postln;
			"Excluding local address from forwarding collection".postln;
		};
		postln("Forwarding message" + msgName + "to:");
		withoutLocalAddr do: _.postln;
		this.addAdapter(OscControl, msgName, { | sender, message |
			var filtered;
			handler ?? { handler.msgCache = message };
			filtered = filter.filter(message);
			withoutLocalAddr do: { | a | a.sendMsg(*filtered); }
		});
	}

	unforwardMsg { | msgName |
		this.removeAdapter(OscControl, msgName.oscMessage);
	}
}

// From sc-hacks-redux. Renamed asOscMessage -> oscMessage
/* 17 Feb 2022 07:17
Convert message to standard osc message format by prepending / if needed
*/

+ Object {
	oscMessage {
		var message;
		message = this.asString;
		if (message[0] != $/) { message = "/" ++ message };
		^message.asSymbol
	}
}