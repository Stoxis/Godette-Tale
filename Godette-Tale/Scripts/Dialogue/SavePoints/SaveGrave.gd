extends StaticBody2D
#class_name InteractableItem

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")
onready var dialogue = tie.get_parent()
onready var save = get_node("/root/Root_Node/CanvasLayer/savePanel")
onready var toggle = true

# By default interactable items are only availble to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func interaction_interact(interactionComponentParent : Node) -> void:
	if !dialogue.is_visible() && !save.is_visible() && toggle:
		$AudioStreamPlayer.stream = load("res://Assets/Sound Effects/HealthRestored.wav")
		$AudioStreamPlayer.play()
		tie.reset()
		tie.portrait_visible(false)
		tie.set_color(Color(1,1,1))
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.NPCid("save")
		tie.buff_panel("show")
		tie.buff_text("* This place...\n", 0.035)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_text("* (HP fully restored.)", 0.035)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_signal("openSavePanel")
		tie.set_state(tie.STATE_OUTPUT)
		globalVariables.disableMenu = true
		toggle = false
	elif !dialogue.is_visible() && !save.is_visible() && !toggle:
		globalVariables.disableMenu = false
		toggle = true
