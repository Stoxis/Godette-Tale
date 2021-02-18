extends StaticBody2D
#class_name InteractableItem

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")
onready var dialogue = tie.get_parent()

# By default interactable items are only availble to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func interaction_interact(interactionComponentParent : Node) -> void:
	if !dialogue.is_visible():
		tie.reset()
		tie.portrait_visible(true)
		tie.NPCid("Sans")
		tie.set_color(Color(1,1,1))
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/Papyrus-UT.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_face("res://Assets/Expressions/Sans/Sans.png")
		#tie.buff_asterisk("show")
		tie.buff_panel("show")
		# Buff text: "Text", duration (in seconds) of each letter
		tie.buff_text("I,\nTHE GREAT PAPYRUS\n", 0.1)
		tie.buff_text("WILL STOP YOU!", 0.2)
		# Buff silence: Duration of the silence (in seconds)
		#tie.buff_silence(1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		#tie.buff_asterisk("hide")
		#tie.buff_asterisk2("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)
