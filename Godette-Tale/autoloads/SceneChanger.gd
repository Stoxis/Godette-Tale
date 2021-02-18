extends CanvasLayer

onready var nodeAnimation = $Control/AnimationPlayer
var scene : String
var _playerPosition : Vector2

func change_scene(new_scene, playerPosition, anim):
	scene = new_scene
	_playerPosition = playerPosition #Save temporary variables to script
	nodeAnimation.play(anim)

func change_scene_fast(new_scene, playerPosition):
	scene = new_scene
	_playerPosition = playerPosition #Save temporary variables to script
	_new_scene()

func _new_scene():
	get_tree().change_scene(scene)
