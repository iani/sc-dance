// 月 14  7 2025 16:07
// Send an array as message to NetAddr.localAddr
// Useful for tests.

+ Array {
	sendLocal { NetAddr.localAddr.sendMsg(*this); }
}
