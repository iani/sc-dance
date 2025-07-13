// 日 13  7 2025 08:38
// Sending '/rokoko/' messages to various net addresses
// Note: To prevent feedback, Avatar never sends '/rokoko/' messages to self.
// Instead, it replaces '/rokoko/' with '/r'.

// 1. Load and start playing the default avatar:
Avatar.play;
// 2. Watch changed notifications from Default avatar on post window:
Avatar.default.simpleTrace;
// 3. Stop posting changed notifications:
Avatar.default.simpleUntrace;
// 4. Start sending to local sclang address.
Avatar.sendToSelf;
// Confirm received messages with OSCFunc.trace
OSCFunc.trace(true, true);
// Lstop tracing
OSCFunc.trace(false);
// 5. Send to godot on local machine
Avatar.sendToGodot;
