// 土  5  7 2025 17:18
// filtering (changing) the rokoko messages through ValueAdapter
// Test array:
m = ['/rokoko/', 0.11143, 'Baubo', 'hip', 100, 40, 55, 20, 0.1, -0.2, 3.14];
f = nil ! m.size;
f[4] = ValueAdapter({ | in | in * 5 });
f[2] = ValueAdapter({ 'giorgos' });
f filter: m;
//:
~pat = (0..100).normalize(-0.5, 0.5).pseq.asStream;
//:
~filter = nil ! 187;
~filter[5] = ValueAdapter({ | in | in + ~pat.next });

//:
~listeners = [
	//	NetAddr.localAddr,
	NetAddr("127.0.0.1", 22245),
	// NetAddr("200.", 22245)
	// add remote addresses from mc later:
	// NetAddr("...", ...),
	// NetAddr("...", ...);
];
