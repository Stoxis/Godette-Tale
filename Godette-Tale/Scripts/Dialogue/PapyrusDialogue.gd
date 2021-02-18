extends StaticBody2D
#class_name InteractableItem

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")
onready var FacialTexture = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine/FacialTexture")
onready var dialogue = tie.get_parent()

# By default interactable items are only availble to the Player class
func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Player

func interaction_interact(interactionComponentParent : Node) -> void:
	if !dialogue.is_visible():
		tie.reset()
		tie.portrait_visible(true)
		tie.set_color(Color(1,1,1))
		tie.NPCid("Papyrus")
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/Papyrus-UT.tres")
		tie.buff_typesound("res://addons/GodotTIE/Papyrus.wav")
		tie.buff_face("res://Assets/Expressions/Papyrus/PapNormal.png")
		#tie.buff_asterisk("show")
		tie.buff_panel("show")
		# Buff text: "Text", duration (in seconds) of each letter
		tie.buff_text("NYEH", 0.065)
		tie.buff_silence(0.10)
		tie.buff_text(" HEH ", 0.065)
		tie.buff_silence(0.10)
		tie.buff_text("HEH!!!", 0.065)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		#tie.buff_asterisk("hide")
		#tie.buff_asterisk2("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)

func _ready():
	# Connect every signal to check them using the "print()" method
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("enter_break", self, "_on_enter_break")
	#tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("typesound", self, "_on_Typesound")
	pass

func _on_buff_end():
	print("Buff End")
	#$AnimationPlayer.play("Idle")
	$Sprite.set_frame(0)
	pass

func _on_enter_break():
	print("Enter Break")
	#$AnimationPlayer.play("Idle")
	$Sprite.set_frame(0)
	pass

#func _on_resume_break():
#	print("Resume Break")
	#$AnimationPlayer.play("Speaking")
#	pass

func _on_Typesound(s):
	if s == "Papyrus":
		#print("Typesound")
		#$AnimationPlayer.play("Speaking")
		if $Sprite.get_frame() == 0:
			FacialTexture.set_texture(load("res://Assets/Expressions/Papyrus/PapNormal1.png"))
			$Sprite.set_frame(1)
			#print("1")
		else:
			FacialTexture.set_texture(load("res://Assets/Expressions/Papyrus/PapNormal.png"))
			$Sprite.set_frame(0)
			#print("0")
		pass

#branching dialogue could go down here?????
#just need to figure out options, then use a signal with a custom string, the answer, to use an if statement on.
