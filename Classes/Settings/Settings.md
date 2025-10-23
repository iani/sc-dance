# Settings class overview

2025-10-21 18:58

- The `Settings` class is used to store sets of settings, where each set is stored as a set of .scd files under a folder.  One can refer to a settings set by its name, which is the name of the folder holding the settings files, and one can access each settings object  in files, grouped under a folder which is as dictionaries of objects 
- The `Settings` class is a subclass of `NamedInstance`. This makes it possible to define many sets of Settings, each set under a unique name.  Any object can access any instance of Settings via its name.  For example `Settings(\paths)` accesses the settings instance named `paths`.  
- A Settings instance store several settings, in a dictionary under  instance variable `settings`. 
- Users are free to organize Settings instances and their dictionaries in any manner they see fit.  For example, one could store settings for a project `myproject` under the Settings instance named by that project `Settings(\myproject)`. Or it could store the folders for sets of audio files for use by any project in `Settings(\audiofolders)`. 
- Settings files are stored in `userAppSupportDir` under folder `Settings` and subfolder named after the name of the Settings instance. For example, the settings for a Setting instance `Setting(\audiofiles)` containing settings named `audiofile1` and `audiofile2` are stored in these 2 files:
```
<userAppSupportDir>/Settings/audiofiles/audiofile1.scd
<userAppSupportDir>/Settings/audiofiles/audiofile2.scd
```
The value of each setting is stored as compile string. 

- The Adapter mechanism is used to notify any dependant objects when a Setting instance changes, for example, when adding, deleting, renaming, or changing the contents of a Setting instance. 
	- When a Setting instance, the Setting class runs `this.changed(\modified, sessionName)`. 
	- When a new Settings instance is created, the Setting class runs   `this.changed(\addSession, sessionName)`.
	- When a new Settings instance is removed, the Setting class runs   `this.changed(\deleteSession, sessionName)`.

