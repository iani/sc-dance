///2. Send arbitrary messages from a whole session
//:load a session into a player
~player = OscPlayer("/Users/iani/oscdata/250414_Nikopoulos_Rokoko/250414_002557/");
//:Check the number of messages in the player
~messages = ~player.messages;
~messages.size;
//:Check that all messages are '/rokoko/'
~messages collect: _.at(0);
// Really make sure all messages start with '/rokoko/':
~messages detect: { | m | m[0] != '/rokoko/' };
//:send the first message
NetAddr("127.0.0.1", 22245).sendMsg(*~messages[0])
NetAddr("127.0.0.1", 22245).sendMsg(*~messages[1000])
//:send messages at random
fork {
	t = 0.5;
	loop {
		NetAddr("127.0.0.1", 22245).sendMsg(*~messages.choose);
		t.value.wait;
	}
};
//:change tempo
t = 0.1;
t = { [0.1, 0.2].choose };
t = [0.2, 0.2, 0.4, 0.8].pseq.asStream;
//:Try with R
fork {
	t = 0.5;
	loop {
		R.send(~messages.choose);
		t.value.wait;
	}
};
//:Use pattern streams for message and time
m = ~messages.pseq.asStream;
m.next;
t = 0.1;
fork {
	t = 0.03;
	loop {
		R.send(m.next);
		t.next.wait;
	}
};
//:change tempo
t = 0.1;
//:play backwards
t = 0.03;
m = ~messages.reverse.pseq.asStream;
//:pyramid
m = ~messages.pyramid.pseq.asStream;
//:freeze arbitrarily
m = ~messages.choose;
//:Trying with R
R.messages_(~messages.pseq).start;
//:change message pattern while playing
R.messages_(~messages.prand);
R.messages_(~messages.reverse.pseq);
R.messages_(~messages.reverse.pseq);
R.messages_(~messages.pyramid.pseq);
R.messages_(~messages[500]);
// Editing!
//:spot the starting point
R.messages_(~messages[600]);
//:cut messages before starting point
R.messages_(~messages[600..].pseq);
//:smaller middle segment
R.messages_(~messages[600..1100].pseq);
