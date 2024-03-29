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
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/Comic-Sans-UT.tres")
		tie.buff_typesound("res://addons/GodotTIE/Sans.wav")
		tie.buff_face("res://Assets/Expressions/Sans/Sans.png")
		tie.buff_panel("show")
		# Buff text: "Text", duration (in seconds) of each letter
		tie.buff_text("* This is a song, ", 0.1)
		tie.buff_text("lalala\n", 0.2)
		# Buff silence: Duration of the silence (in seconds)
		tie.buff_silence(1)
		tie.buff_face("res://Assets/Expressions/Sans/Sans1.png")
		tie.buff_text("* It is so beautiful,\n", 0.1)
		tie.buff_text("  lalala", 0.2)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_text("* Turn around and shake\n", 0.15)
		tie.buff_text("  my hand.", 0.15)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)

func _ready():
	# Connect every signal to check them using the "print()" method
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")
	#tie.connect("typesound", self, "_on_Typesound")
	pass

func _on_input_enter(s):
	print("Input Enter ",s)
	
	tie.add_newline()
	tie.buff_text("Oooh, so your name is " + s + "? What a beautiful name!", 0.01)
	pass

func _on_buff_end():
	print("Buff End")
	pass

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	print("Resume Break")
	pass

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass

#func _on_Typesound():
#	print("Typesound")
#	pass
