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


