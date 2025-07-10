//:load a session into a player
~player = SessionData("/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_002557/");
//:Check the number of messages in the player
~messages = ~player.messages;
~messages.size;
//:test playback
R.messages_(~messages[600..1100].pseq);
R.start;
R.pause;
R.resume;
R.stop;

R.times = 30.reciprocal;

.messages_(~messages[600..1100].prand);

P
//:Test filters
R.addFilter({ 1.5 }, \hip, 2);
R.addFilter({ -0.1 }, \hip, 2);
R.addFilter({ |in| in + 0.1 }, \leftHand, 4);
R.addFilter({ |in| in + 4.1 }, \leftHand, 5);
R.addFilter({ |in, val, bus | in + bus[0] }, \leftHand, 5);
//:

//:
R.messages = ~messages[600..1100].pyramid.pseq;
//:
R.times = 0.03;
//:
R.msgCache select: _.isKindOf(Symbol);

//:a little animation
r = fork {
	var y, ypat;
	y = (1..100).normalize(-0.5, 1.5);
	y = y ++ y.reverse;
	ypat = y.pseq.asStream;
	inf do: {
		R.addFilter({ ypat.next }, \hip, 2);
		1.wait;
	}
};
//:
r.stop;

R.addFilter({ 2 }, \hip, 2);
R.filter;
R.filter.filter(R.msgCache);
//:

//:
~conway20 = SurrealAlgorithms.conwayConstruction(200);
//:
~conway20;
//:
~indices = (0..~messages.size);
0.5.linlin(0, 1, 0, ~messages.size -1).floor;
//:
~conway20segments = nil;
~conway20 pairsDo: { | b, e |
	~conway20segments = ~conway20segments add: [
		b.linlin(0, 1, 0, ~messages.size -1).floor.asInteger,
		e.linlin(0, 1, 0, ~messages.size -1).floor.asInteger,
	].sort;
};
//:
~conway20segments;
~conway20segments.first;
//:
~messages.copyRange(*~conway20segments.first).size;
~messages.copyRange(*~conway20segments[1]).size;
//:
~conway20messages = ~messages.copyRange(*~conway20segments.first) ++
~messages.copyRange(*~conway20segments[1]);
//:
~conway20messages = [];
~conway20segments do: { | cm |
	~conway20messages = ~conway20messages ++ ~messages.copyRange(*cm)
};
//:
~conway20messages.size;
//:
R.messages = ~conway20messages.pseq;
R.start;
//:COMPARE!
R.messages = ~messages.pseq;
R.start;
//
R.stop;
//
//:
~messages.copyRange(0, 1)
//:

//:
R.messages = ~messages.pseq;
~messages.pseq.reset;

~messages.first.reset;
//:
R.start;
R.pause;
R.resume;
R.stop;
~task = R.task;
~tast.pause;