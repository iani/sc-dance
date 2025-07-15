// 日 13  7 2025 08:38
// Sending '/rokoko/' messages to various net addresses
// Note: To prevent feedback, Avatar never sends '/rokoko/' messages to self.
// Instead, it replaces '/rokoko/' with '/r'.

// 1. Send to godot on local machine
Avatar.sendToGodot;
// 2. Load and start playing the default avatar:
// Load session named \fidgety_introvert (see Animations folder)
Avatar.loadNamed(\fidgety_introvert).play;

// 3. Watching messages sent by Avatar
// Watch changed notifications from Default avatar on post window:
Avatar.default.simpleTrace;
// Stop posting changed notifications:
Avatar.default.simpleUntrace;
// Start sending to local sclang address.
Avatar.sendToSelf;
// Confirm received messages with OSCFunc.trace
TraceOsc.enable;
// Stop tracing
TraceOsc.disable;

// Extra: Pausing and resuming
Avatar.pause;
Avatar.resume;
