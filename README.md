# Godette-Tale
Undertale template for Godot

## Features:
### Player Controller
* Player animates exactly how it does in Undertale
* Easy Camera Boundaries
* Ability to interact
### Puzzles
* Fully functional Door with customizable whitelisted passphrases and object activation count to open
* Fully functional Spikes with customizable whitelisted passphrases and object activation count to open
* Lever with customizable scene activation location (to open doors/spikes in other levels) and passphrase string 
* Button with customizable scene activation location (to open doors/spikes in other levels) and passphrase string
* Do not worry! All puzzle objects (doors, spikes, levers, buttons) remember their state, they will not reset if you leave the room and come back
### Dialogue
* NPCs can speak dialogue
* NPCs can have custom portraits, fonts, and typing sounds
* NPCs can change their portraits on the fly, this allows for different emotions and for a animated talking portrait (examples *are* provided in the project)
### Saving
* Undertale is a modern game! You do not need to play the entire thing in one setting, and the same goes for games created with the Godette-Tale project template
* Save stars can be placed and given unique dialogue
* Save stars save the Player's location, LOVE, NAME, Playtime, the current location's room description, and all puzzle object states  
* Room descriptions are set in the Root_Node of the current scene the player is in
### Music
* Music does not restart upon entering a different scene and instead contintues playing
* Music can be stopped, changed, or paused on the fly 
* Music is generally set in the Root_Node of the scene
