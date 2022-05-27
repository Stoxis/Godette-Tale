extends StaticBody2D
export var strSignal : String #String ID and activationLocation can be set in the inspector
export(String, FILE, "*.tscn") var activationLocation #Default_Value: "Current Scene" #A button can trigger something in a different scene with this setting
var is_pulled := false
var aryDump : Array

func _ready():
	if !activationLocation: #if there's no alternate location set
		activationLocation = get_tree().current_scene.filename #set it to the current scene
	if globalVariables.objectList.has(str(get_tree().current_scene.filename)): #contiune if there are pulled levers found in this scene
		aryDump = globalVariables.objectList[str(get_tree().current_scene.filename)].split(", ")
		if aryDump.find(self.name) != -1: #check if self is one of the pulled levers
			$Sprite.set_frame(3) #lever is visibly pulled
			is_pulled = !is_pulled #is_pulled = true

# By default interactable items are only available to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func interaction_interact(interactionComponentParent : Node) -> void: #on lever pull attempt
	if !is_pulled: #if lever hasn't been pulled yet
		signalManager.emit_signal("object_activated", strSignal) #send signal with unique stringID
		$Sprite.set_frame(3) #lever is visibly pulled, frame 2 is the "unpulled" variant
		is_pulled = !is_pulled #is_pulled = true
		if !globalVariables.activationList.has(str(activationLocation)): #if there are no activations found in this scene
			globalVariables.activationList[str(activationLocation)] = strSignal #save new scene with new activation
		else: #if there are previous activations found in this scene
			globalVariables.activationList[str(activationLocation)] += ", " + strSignal #save this activation along with all previous activations found in this scene
		if !globalVariables.objectList.has(str(get_tree().current_scene.filename)): #if there are no activated objects found in this scene
			globalVariables.objectList[str(get_tree().current_scene.filename)] = self.name #save new scene with new activated object name
		else: #if there are previously activated objects found in this scene
			globalVariables.objectList[str(get_tree().current_scene.filename)] += ", " + self.name #save this object along with all previous objects found in this scene
