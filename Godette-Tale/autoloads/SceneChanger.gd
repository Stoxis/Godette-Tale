extends CanvasLayer

onready var nodeAnimation = $Control/AnimationPlayer
var scene : String
var _playerPosition : Vector2

func change_scene(new_scene, playerPosition, anim):
	if !globalVariables.exitingShop: # This is to fix a bug where the menu is disabled when you leave a shop due to the transition to enter the shop being called immediately upon exiting the shop.
		globalVariables.disableMenu = true #Disable menu so the player can't open it during fade out
		scene = new_scene
		_playerPosition = playerPosition #Save temporary variables to script
		nodeAnimation.play(anim)
	else: # Disable it after the false positive is detected.
		globalVariables.exitingShop = false

func change_scene_fast(new_scene, playerPosition):
	globalVariables.disableMenu = true #Disable menu so the player can't open it during fade out
	scene = new_scene
	_playerPosition = playerPosition #Save temporary variables to script
	_new_scene()

func _new_scene():
	get_tree().change_scene(scene)
	globalVariables.disableMenu = false #Re-enable menu 
