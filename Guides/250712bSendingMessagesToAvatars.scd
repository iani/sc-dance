//土 12  7 2025 20:47
// Sending messages to Avatars.
// 1. Sending messages to the default avatar.
// Sending a message to Avatar performs the instance method
// on the default avatar.
Avatar.play; // start the default avatar
// this is equivalent to:
Avatar(\default).play;
//: Another example:
Avatar.stop; // stop the default avatar;
// This is equivalent to:
Avatar(\default).stop;
// 2. Sending messages to an avatar with custom name
Avatar(\blueboy).play; // start avatar named blueboy
Avatar(\blueboy).stop; // stop avatar named blueboy