// 木  3  7 2025 17:35
// Forward rokoko data to osc addresses
// In response to changed \msg messages from
// OscSequence listening to OscController.

RokokoForwarder : NamedInstance {
	var <>addr; // addresses to forward to
	var filters; // array of ValueAdapters for
	var <>msgCache;
	var <isEnabled = false;
	// filtering (modifying) the rokoko osc message array.

	enable {
		addr.forwardMsg('/rokoko/', filters, this);
		isEnabled = true;
	}

	disable {
		addr unforwardMsg: '/rokoko/';
		isEnabled = false;
	}

	addFilter { | filterFunc, jointName, offset = 1 |
		var index;
		index = msgCache indexOf: jointName;
		this.filters[index + offset] = filterFunc.asFilter;
		this.filters = filters;
	}

	filters {
		^filters ?? { filters = nil ! msgCache.size };
	}

	filters_ { | argFilters |
		filters = argFilters;
		if (isEnabled) { // update filters in forward action
			this.disable;
			this.enable;
		}
	}
}