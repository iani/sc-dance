// Loading Sessions in Avatars

// 1. Load the default session to the default avatar
Avatar.load;

// 2. Load a session from a user specified path to Avatar.default:
Avatar.load(<aPath>);
// Example:
Avatar.load("/Users/iani/Library/Application Support/SuperCollider/Extensions/sc-dance/Data/Animations/250414_003102/");

// 3. The default session path
//The default session path is given by:
ScDanceSessions.defaultPath;
//This is implemented as:
// this.sessionsDict[this.sessionNames.first];
// This is the first subfolder (alphabetically) of Data/Animations
// folder in sc-dance library folder.
//Load the default session into Avatar.default:
Avatar.load(ScDanceSessions.defaultPath);
//
// 3. Load a session from a path chosen by a FileDialog:
Avatar.loadDialog;
// This opens a FileDialog for selecting a folder.
// Select a folder that contains the .scd files for a single session.

// 4. Load a session by the name of its folder
Avatar.loadNamed(\speed_contrast);
// To list the names of all sessions currently known to the system:
Avatar.allSessionNames;
// Example: Load a session chosen at random from all session names:
Avatar loadNamed: Avatar.allSessionNames.choose;

//5. Loading sessions to an avatar specified by name
//(Not the default avatar).
//Examples:
Avatar(\blueboy).load; // load the default session into Avatar \blueboy
//:load a session from a custom path into Avatar \blueboy
Avatar(\blueboy)
.load("/Users/iani/Library/Application Support/SuperCollider/Extensions/sc-dance/Data/Animations/250414_003102/");
//:Other examples
Avatar(\blueboy).load(ScDanceSessions.defaultPath);
Avatar(\blueboy).loadDialog;
Avatar(\blueboy).loadNamed(\speed_contrast);
Avatar(\blueboy) loadNamed: Avatar.allSessionNames.choose;
