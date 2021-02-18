extends Control

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")

func _ready():
	# "A Beautiful Song"
	# by Henrique Alves
	tie.set_color(Color(1,1,1))
	tie.buff_face("res://Assets/Expressions/Sans/Sans.png")
	tie.buff_asterisk("show")
	tie.buff_panel("show")
	# Buff text: "Text", duration (in seconds) of each letter
	tie.buff_text("This is a song, ", 0.1)
	tie.buff_text("lalala\n", 0.2)
	# Buff silence: Duration of the silence (in seconds)
	tie.buff_silence(1)
	tie.buff_face("res://Assets/Expressions/Sans/Sans1.png")
	tie.buff_asterisk2("show")
	tie.buff_text("It is so beautiful, ", 0.1)
	tie.buff_text("lalala", 0.2)
	tie.buff_break()
	tie.buff_clear()
	tie.buff_asterisk("hide")
	tie.buff_asterisk2("hide")
	tie.buff_silence(1)
	tie.buff_asterisk("show")
	tie.buff_face("res://Assets/Expressions/Sans/Sans.png")
	tie.buff_text("I love this song, ", 0.1)
	tie.buff_text("lalala", 0.2)
	tie.buff_break()
	tie.buff_clear()
	tie.buff_text("But now I'll ", 0.1) # WAIT FOR THE DROP
	tie.buff_text("DROP ", 0.02) # ?????
	tie.buff_silence(0.4)
	tie.buff_text("THE BASS\n", 0.02) # !!!!!
	tie.buff_silence(0.4)
	tie.buff_face("res://Assets/Expressions/Sans/Sans1.png")
	tie.buff_text("TVUVTUVUTUVU", 0.04) # I firmly believe this particular verse is my Magna Opus.
	tie.buff_asterisk("hide")
	tie.buff_text("WOODBODBOWBDODBO TUUVUTVU WODWVDOOWDV WODOWVOOWDVOWVD DUBDUBDUBUDUDB OWVDOWVWDOWVDOWVDOWVDWVDOWVDOWVODV", 0.04) # I firmly believe this particular verse is my Magna Opus.
	tie.buff_break()
	tie.buff_clear()
	tie.buff_panel("hide")
	tie.buff_asterisk("hide")
	tie.buff_face("res://Assets/Expressions/None.png")
	
	# Connect every signal to check them using the "print()" method
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")
	pass

func _on_input_enter(s):
	print("Input Enter ",s)
	
	tie.add_newline()
	tie.buff_text("Oooh, so your name is " + s + "? What a beautiful name!", 0.01)
	tie.buff_break()
	tie.buff_panel("hide")
	tie.buff_asterisk("hide")
	tie.buff_face("res://Assets/None.png")
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
