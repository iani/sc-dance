// 月 14  7 2025 18:06
// Play with an avatar with custom name.
// This enables you to control your avatar by name,
// when playing in a scene with multiple avatars.

//:1. Create an Avatar with a name, and make it default:
Avatar(\cat).makeDefault;
//:2. Check that the default Avatar is indeed the one you made:
Avatar.default; // should post: Avatar<cat>
// 3. Configure to send messages to local address
// Note: to prevent feedback, messages sent to self have OSC address '/r'.
Avatar.sendToSelf;
// 4. Post received messages to the post window
TraceOsc.enable;
// 5. Start playing the default avatar
Avatar.play;
// 5. Stop posting received messages
TraceOsc.disable;
