// 土  5  7 2025 17:18
// filtering (changing) the rokoko messages through ValueAdapter
// Test array:
m = ['/rokoko/', 0.11143, 'Baubo', 'hip', 100, 40, 55, 20, 0.1, -0.2, 3.14];
f = nil ! m.size;
f[4] = ValueAdapter({ | in | in * 5 });
f[2] = ValueAdapter({ 'giorgos' });
f filter: m;
//:
~pat = (0..100).normalize(-10.5, 10.5).pseq.asStream;
//:
~filter = nil ! 187;
~filter[14] = ValueAdapter({ | in | in * ~pat.next });
~filter[14] = ValueAdapter({ | in | 0 });
~filter[15] = ValueAdapter({ | in | 0 });
~filter[16] = ValueAdapter({ | in | 0 });
~filter[17] = ValueAdapter({ | in | 0 });
~filter[18] = nil;
~filter[19] = ValueAdapter({ | in | 20 });
~filter[20] = ValueAdapter({ | in | 20 });
~filter[21] = ValueAdapter({ | in | 20 });
~filter[22] = ValueAdapter({ | in | 20 });
~filter[23] = ValueAdapter({ | in | 20 });
~filter[24] = ValueAdapter({ | in | 20 });
~filter[25] = ValueAdapter({ | in | 20 });
~filter[26] = ValueAdapter({ | in | 20 });
~filter[27] = ValueAdapter({ | in | 20 });
~filter[28] = ValueAdapter({ | in | 20 });
~filter[29] = ValueAdapter({ | in | 20 });
~filter[30] = ValueAdapter({ | in | 20 });
~filter[31] = ValueAdapter({ | in | 20 });
~filter[32] = ValueAdapter({ | in | 20 });
~filter[33] = ValueAdapter({ | in | -10.1.rrand(20) });
~filter[34] = ValueAdapter({ | in | -0.1 rrand: 20 });

~filter[15] = ValueAdapter({ | in | -10.1.rrand(20) });
//:
~listeners = [
	//	NetAddr.localAddr,
	NetAddr("127.0.0.1", 22245),
	// NetAddr("200.", 22245)
	// add remote addresses from mc later:
	// NetAddr("...", ...),
	// NetAddr("...", ...);
];
//:
OscControl.enable;
OscControl.simpleTrace;
OscControl.simpleUntrace;
//:
\forwarder.addAdapter(OscControl, '/rokoko/', { | a, msg |
	NetAddr("127.0.0.1", 22245).sendMsg(*msg);
});
//:
\forwarder.removeAdapter(OscControl, '/rokoko/');
//: FILTER!
~sin = (0..100).normalize.pseq.asStream;
~filter[13] = ValueAdapter({ | in | 1 });
~filter[14] = ValueAdapter({ | in | 1 });
~filter[15] = ValueAdapter({ | in | 1 });
~filter[16] = ValueAdapter({ | in | 1 });
~filter[17] = ValueAdapter({ | in | sin(~sin.next) });
~filter[16] = ValueAdapter({ | in | sin(~sin.next) });

//:
\forwarder.addAdapter(OscControl, '/rokoko/', { | a, msg |
	msg = ~filter.filter(msg);
	NetAddr("127.0.0.1", 22245).sendMsg(*msg);
});
//:
\forwarder.addAdapter(OscControl, '/rokoko/', { | a, msg |
	msg.postln;
});