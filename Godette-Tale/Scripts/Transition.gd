extends Area2D
export(String, FILE) var new_scene
export(Vector2) var playerPosition

func _on_Transition_body_entered(body):
	if body is Player:
		#print(str(get_tree().current_scene.filename))
		#print(str(new_scene))
		SceneChanger.change_scene(new_scene, playerPosition, "fade")
