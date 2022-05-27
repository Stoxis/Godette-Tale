extends StaticBody2D
export(Array, String) var aryActivationPhrases #Strings that'll be accepted as one of the 'activation(s)'
export var intMaxActivationCount : int #Amount of signals required before opening
var intActivationCount : int = 0 #Amount of acceptable signals receieved

func _ready():
	signalManager.connect("object_activated", self, "_on_object_activated")
	if globalVariables.activationList.has(str(get_tree().current_scene.filename)): #Check if there are any objects already activated in this scene
		for item in globalVariables.activationList[str(get_tree().current_scene.filename)].split(", "): #Loop through all saved activation phrases
			_on_object_activated(str(item)) #Send saved phrases through function

func _on_object_activated(s):
	#print(s)
	if str(s) in aryActivationPhrases: #Check if received signal is acceptable
		intActivationCount += 1 #Count the activation
		if intMaxActivationCount == intActivationCount:
			self.hide() #Hide the door
			$CollisionShape2D.set_deferred("disabled", true) #Turn off the collider
