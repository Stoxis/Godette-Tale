extends Node2D

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")
onready var dialogue = tie.get_parent()

func _init():
	globalVariables.cellList = ["sans' Phone","Gaster"]

func _ready():
	globalVariables.currentRoomDesc = "The void"
	MusicController.play_music("res://Assets/Music/Amalgam.wav")
	signalManager.connect("cell", self, "_on_cellphone_activated")
	tie.connect("buff_end", self, "_on_buff_end")
	signalManager.connect("buff_signal", self, "_on_buff_signal_activated")
	#print(globalVariables.cellList.join("\n"))
	
func _on_buff_end():
	$"/root/Root_Node/CanvasLayer/infoPanel".hide()
	globalVariables.menuOpen = false
	
func _on_cellphone_activated(s):
	if s == "sans' Phone":
		sans01()
	if s == "Gaster":
		mysteryman01()
#signalManager.emit_signal("cell","sans")

func _on_buff_signal_activated(s):
	if s == "portrait hidden":
		tie.rect_position = Vector2( 24, 22 )
		tie.rect_size = Vector2( 560, 144 )
	if s == "portrait visible":
		tie.rect_position = Vector2( 128, 22 )
		tie.rect_size = Vector2( 432, 144 )
	if s == "comic sans":
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/Comic-Sans-UT.tres")
	pass

var sans01 = false
func sans01():
	if !dialogue.is_visible() && !sans01:
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".stream = load("res://Assets/Sound Effects/PhoneRing.wav")
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".play()
		tie.reset()
		tie.portrait_visible(false)
		tie.NPCid("Sans")
		tie.set_color(Color(1,1,1))
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_panel("show")
		tie.buff_text("* Ring...", 0.1)
		tie.buff_silence(1)
		tie.buff_text(" Ring...", 0.1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_signal("portrait visible")
		tie.buff_signal("comic sans") #you gotta add in the font above
		tie.buff_typesound("res://addons/GodotTIE/Sans.wav")
		tie.buff_face("res://Assets/Expressions/Sans/Sans.png")
		# Buff text: "Text", duration (in seconds) of each letter
		tie.buff_text("* what's up kid.\n", 0.08)
		# Buff silence: Duration of the silence (in seconds)
		tie.buff_silence(1)
		tie.buff_face("res://Assets/Expressions/Sans/Sans1.png")
		tie.buff_text("* wanna go to grillbys?", 0.08)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)
		sans01 = true
	elif !dialogue.is_visible() && sans01:
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".stream = load("res://Assets/Sound Effects/PhoneRing.wav")
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".play()
		tie.reset()
		tie.portrait_visible(false)
		tie.NPCid("Sans")
		tie.set_color(Color(1,1,1))
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_panel("show")
		tie.buff_text("* Ring...", 0.1)
		tie.buff_silence(1)
		tie.buff_text(" Ring...", 0.1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_text("No answer.\nIt's not like the first call\nwas real anyway.", 0.1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)

func mysteryman01():
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".stream = load("res://Assets/Sound Effects/PhoneRing.wav")
		$"/root/Root_Node/CanvasLayer/infoPanel/AudioStreamPlayer".play()
		tie.reset()
		tie.portrait_visible(false)
		tie.NPCid("Gaster")
		tie.set_color(Color(1,1,1))
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_panel("show")
		tie.buff_text("* Ring...", 0.1)
		tie.buff_silence(1)
		tie.buff_text(" Ring...", 0.1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_text("No response.", 0.1)
		tie.buff_break()
		tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)
