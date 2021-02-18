extends Area2D
export var strSignal : String #String ID and activationLocation can be set in the inspector
export(String, FILE, "*.tscn") var activationLocation #Default_Value: "Current Scene" #A button can trigger something in a different scene with this setting
var is_pressed := false
var aryDump : Array

func _ready():
	if !activationLocation:
		activationLocation = get_tree().current_scene.filename
	if globalVariables.objectList.has(str(get_tree().current_scene.filename)): #continue if there are pressed buttons found in this scene
		aryDump = globalVariables.objectList[str(get_tree().current_scene.filename)].split(", ")
		if aryDump.find(self.name) != -1: #check if self is one of the pressed buttons
			$Sprite.set_frame(1) #button is visibly pressed
			is_pressed = !is_pressed #is_pressed = true

func _on_Button_body_entered(body): #on button pressed
	if body is Player && !is_pressed:
		signalManager.emit_signal("object_activated", strSignal) #send signal with unique stringID
		$Sprite.set_frame(1) #button is visibly pressed
		is_pressed = !is_pressed #is_prssed = true
		if !globalVariables.activationList.has(str(activationLocation)): #if there are no activations found in this scene
			globalVariables.activationList[str(activationLocation)] = strSignal #save new scene with new activation
		else: #if there are previous activations found in this scene
			globalVariables.activationList[str(activationLocation)] += ", " + strSignal #save this activation along with all previous activations found in this scene
		if !globalVariables.objectList.has(str(get_tree().current_scene.filename)): #if there are no activated objects found in this scene
			globalVariables.objectList[str(get_tree().current_scene.filename)] = self.name #save new scene with new activated object name
		else: #if there are previously activated objects found in this scene
			globalVariables.objectList[str(get_tree().current_scene.filename)] += ", " + self.name #save this object along with all previous objects found in this scene
