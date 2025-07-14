// 月 14  7 2025 10:28
// Open a gui for viewing the values of the message
// and of user generated controls.

Avatar.valuesGui; // open the gui

// Note 1: One can combine messages in a chain, to
// both open the gui and start playing, like this:

Avatar.valuesGui.play;

// Note 2:
// One can add a sendToCodot message to start animation in godot

Avatar.valuesGui.play.sendToGodot;
