extends Node
#This node exists solely to collect and send signals to other parts of the application
#So any signal needing to be retrieved can simply come here to get the data.
#This is a singleton.

signal object_activated(s) #Used by all puzzle objects and the saving system to read and write activations
signal save_update()  #Used by globalVariables.gd to update the UI in Save.gd when save button is pushed in the UI
signal buff_signal(s)  #Used by the dialogue system to send any string you want at a specific time while text is being typed, it's currently used to make the save panel appear at the right time in Save.gd

#Save.gd handles the save star UI

#globalVariables.gd handles the actual saving of all global variables

#Every room can have a separate music track, if one isn't provided it will continue using the song from the last room

#Every room with a save star must have a description provided in the root node

#Every level requires a Camera and a Player with a remote transform attached to the Camera 

#Every level requires the root node to be named "Root_Node"

#The Camera2D comes with "Limits", these two nodes handle the boundaries that the Camera is allowed to track the player in
