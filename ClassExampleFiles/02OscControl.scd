//: 土  5  7 2025 07:26
OscControl.enable;
//:
OscControl.simpleTrace;
fork {
	10 do: { | i |
		NetAddr.localAddr.sendMsg([\test, \blah].choose, i, 100.0.rand);
		0.5.wait;
	}
}
//:
OscControl.simpleUntrace;
fork {
	10 do: { | i |
		NetAddr.localAddr.sendMsg([\test, \blah].choose, i, 100.0.rand);
		0.5.wait;
	}
}
