// 木  3  7 2025 17:35
// Forward rokoko data to osc addresses
// In response to changed \msg messages from
// OscSequence listening to OscController.

RokokoForwarder : NamedInstance {
	var <>addr; // addresses to forward to

	*osc { | ... args | args.postln; }

}