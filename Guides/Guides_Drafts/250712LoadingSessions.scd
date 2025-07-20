//土 12  7 2025 20:47
// 1. The default Avatar
// Per default, the default avatar is an Avatar named \default.
Avatar.default;
// One can geta an avatar of a given name by running Avatar.new(<a name>);
// For example:
Avatar(\default); // get the default avatar
// Confirm:
Avatar.default === Avatar(\default);
// 2. Creating other avatars
// Get an avatar named "blueboy"
Avatar(\blueboy);
// 3. Making any avatar default:
Avatar(\blueboy).makeDefault;
// Confirm:
Avatar.default === Avatar(\blueboy);

// 4. Working with the default Avatar
// Sending a message to Avatar runs the corresponding method on
// the default Avatar. For example:
Avatar.load; // load the default session to the default avatar

// Load a session from a path to Avatar.default:
Avatar.load(<aPath>); // substitute <aPath> with an existing path
                   // on your computer.
// Example:
Avatar.load("/Users/iani/Library/Application Support/SuperCollider/Extensions/sc-dance/Data/Animations/250414_003102/");

// 5. Load a session from a path chosen by a FileDialog:

//The default session path is given by:
ScDanceAssets.defaultPath;
//This is implemented as:
// this.sessionsDict[this.sessionNames.first];
// This is the first subfolder (alphabetically) of Data/Animations
// folder in sc-dance library folder.
//Load the default session into Avatar.default:
Avatar.load(ScDanceAssets.defaultPath.postln);
//
// To list the names of all sessions currently known to the system:
Avatar.allSessionNames;
