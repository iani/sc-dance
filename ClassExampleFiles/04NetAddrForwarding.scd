//土  5  7 2025 12:43
NetAddr.localAddr.forwardMsg(\x);
NetAddr("127.0.0.1", 12334).forwardMsg(\x);
NetAddr
//:
OscControl.enable;
OscControl.dontTrace;
//:
NetAddr.localAddr.sendMsg(\x, 1, 2, 3);
NetAddr.localAddr.sendMsg(\ydonotprint, 1, 2, 3);