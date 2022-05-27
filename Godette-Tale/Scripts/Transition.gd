extends Area2D
export(String, FILE) var new_scene
export(Vector2) var playerPosition
export(bool) var isShop
#export(Vector2) var shopExitPosition

func _on_Transition_body_entered(body):
	if body is Player:
		#print(str(get_tree().current_scene.filename))
		#print(str(new_scene))
		if isShop:
			globalVariables.exitShopPosition = body.get_position()
			#globalVariables.exitShopPosition = shopExitPosition
			globalVariables.exitShopScene = get_tree().get_current_scene().filename
		SceneChanger.change_scene(new_scene, playerPosition, "fade")
