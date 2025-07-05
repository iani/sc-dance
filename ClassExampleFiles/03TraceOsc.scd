//:土  5  7 2025 08:43
//:
TraceOsc.enable;
fork {
	10 do: { | i |
		NetAddr.localAddr.sendMsg([\test, \blah].choose, i, 100.0.rand);
		0.5.wait;
	}
}
