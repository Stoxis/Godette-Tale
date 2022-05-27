extends Node2D

onready var tieInter = get_node("/root/Root_Node/InterPanel/InterPanelText")
onready var tieBuy = get_node("/root/Root_Node/BuyPanel/BuyPanelText")
onready var tieInfo = get_node("/root/Root_Node/BuyPanel/InfoPanel/InfoPanelText")
onready var shopkeeperSprite : Sprite = get_node("Shopkeeper")
onready var shopkeeperAnim = get_node("Shopkeeper/AnimationPlayer")
onready var lastTypesound : String

# I coded it so you can change max inventory size in globalVariables.gd and 
# everything will still work, you might need to change the font-size, and 
# change the sellElementPerColumn or make the menu panel bigger for it to
# look good but no errors/crashes will occur if you make the inventory larger.

# Shop Variables
var isSelling : bool = true # Does this shopkeeper buy player items?
var soldLabel : String = "SOLD" #What is displayed in lieu of an item after you sell it
var sellElementPerColumn : int = 4 # This changes how many inventory items are displayed per colunm in the sell menu
func _init(): # More shop variables
	globalVariables.talkList = ["The void","The strange man"]
	globalVariables.shopInventory = [2, 3, 0, 1] # ItemIDs for items the shopkeeper will sell

func _on_talk_choice(s): # You link your talkList strings to functions that contain your dialogue here.
	if s == "The void":
		example()
	if s == "The strange man":
		example()

func example(): # This is a function that displays dialogue
	if get_node("/root/Root_Node/InterPanel/talkOptions").is_visible():
		get_node("/root/Root_Node/InterPanel/talkOptions").hide()
		tieInter.reset()
		tieInter.NPCid("Example")
		tieInter.set_color(Color(1,1,1))
		tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tieInter.buff_text("* ...", 0.1)
		tieInter.buff_silence(1)
		tieInter.buff_text(" you wouldn't want to know.", 0.1)
		tieInter.buff_break()
		tieInter.buff_clear()
		tieInter.buff_signal("talkEnd")
		tieInter.buff_face("res://Assets/Expressions/None.png")
		tieInter.set_state(tieInter.STATE_OUTPUT)

func _ready() -> void:
	signalManager.connect("talk", self, "_on_talk_choice")
	signalManager.connect("buff_signal", self, "_on_buff_signal_activated")
	tieInter.connect("buff_end", self, "_on_buff_end")
	tieInter.connect("typesound", self, "_on_Typesound")
	tieBuy.connect("typesound", self, "_on_Typesound")
	tieInter.connect("buff_end", self, "_on_stop_type")
	tieInter.connect("enter_break", self, "_on_stop_type")
	tieBuy.connect("buff_end", self, "_on_stop_type")
	tieBuy.connect("enter_break", self, "_on_stop_type")
	greeting()

func _on_Typesound(s): #when shopkeeper is talking, filtered by npcid
	if s == "Example": # This is the NPC ID, it's used to differentiate who is currently speaking.
		#lastTypesound = s
		shopkeeperAnim.play("Speaking", 0)
		#if shopkeeperSprite.get_frame() == 0:
		#	shopkeeperSprite.set_frame(1)
		#else:
		#	shopkeeperSprite.set_frame(0)

func _on_stop_type(): #when shopkeeper stops talking
	print("stop")
	#if lastTypesound == "Example":
		#pass
		#shopkeeperSprite.set_frame(0)

func infoText(x):
	tieInfo.reset()
	tieInfo.set_color(Color(1,1,1))
	tieInfo.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Shop.tres")
	tieInfo.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInfo.buff_text(x, 0)
	tieInfo.set_state(tieInter.STATE_OUTPUT)

func greeting():
	tieInter.reset()
	tieInter.NPCid("Example")
	tieInter.set_color(Color(1,1,1))
	tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInter.buff_text("* Greetings", 0.05)
	tieInter.set_state(tieInter.STATE_OUTPUT)

func rtrnGreeting():
	tieInter.reset()
	tieInter.NPCid("Example")
	tieInter.set_color(Color(1,1,1))
	tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInter.buff_text("* Go on", 0.05)
	tieInter.set_state(tieInter.STATE_OUTPUT)

func buyGreet():
	tieBuy.reset()
	tieBuy.NPCid("Example")
	tieBuy.set_color(Color(1,1,1))
	tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieBuy.buff_text("What would\nyou like?", 0.05)
	tieBuy.set_state(tieInter.STATE_OUTPUT)

func rtrnBuyGreet():
	tieBuy.reset()
	tieBuy.NPCid("Example")
	tieBuy.set_color(Color(1,1,1))
	tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieBuy.buff_text("Just\nbrowsing?", 0.05)
	tieBuy.set_state(tieInter.STATE_OUTPUT)

func buyReact(x):
	tieBuy.reset()
	tieBuy.NPCid("Example")
	tieBuy.set_color(Color(1,1,1))
	tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
	match(x):
		"Not enough gold":
			tieBuy.buff_text("That's not\nenough\nmoney.", 0.05)
		"Not enough inventory":
			tieBuy.buff_text("Your\ninventory\nis full.", 0.05)
		"Item purchased":
			tieBuy.buff_text("Come\nagain!", 0.05)
	tieBuy.set_state(tieInter.STATE_OUTPUT)

						# Check gold
						# >  Not enough gold message
						# Check inventory space
						# >  Not space message
						# Subtract gold
						# >  Item purchased message
						# Add item

func notSelling():
	tieInter.reset()
	tieInter.NPCid("Example")
	tieInter.set_color(Color(1,1,1))
	tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInter.buff_text("* I'm not buying.", 0.05)
	tieInter.set_state(tieInter.STATE_OUTPUT)

func noItemsToSell():
	tieInter.reset()
	tieInter.NPCid("Example")
	tieInter.set_color(Color(1,1,1))
	tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInter.buff_text("* You don't have any\n  items.", 0.05)
	tieInter.set_state(tieInter.STATE_OUTPUT)

func talkGreet():
	tieBuy.reset()
	tieBuy.NPCid("Example")
	tieBuy.set_color(Color(1,1,1))
	tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieBuy.buff_text("Care to\nchat?", 0.05)
	tieBuy.set_state(tieBuy.STATE_OUTPUT)

func _on_buff_signal_activated(s):
	if s == "comic sans":
		tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/Comic-Sans-UT.tres")
	if s == "talkEnd":
		get_node("/root/Root_Node/InterPanel/talkOptions").show()
		tieBuy.reset()
		tieBuy.NPCid("Example")
		tieBuy.set_color(Color(1,1,1))
		tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tieBuy.buff_text("Anything\nelse?", 0.05)
		tieBuy.set_state(tieBuy.STATE_OUTPUT)
	pass

func _on_buff_end():
	get_node("/root/Root_Node/BuyPanel").disableMenu = false
	get_node("/root/Root_Node/BuyPanel").show()

func clear():
	tieInter.reset()
	tieInter.buff_clear()
	tieInter.set_state(tieInter.STATE_OUTPUT)
	tieBuy.reset()
	tieBuy.buff_clear()
	tieBuy.set_state(tieInter.STATE_OUTPUT)

func buyTalk(x):
	tieBuy.reset()
	tieBuy.NPCid("Example")
	tieBuy.set_color(Color(1,1,1))
	tieBuy.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieBuy.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieBuy.buff_text(x, 0.1)
	tieBuy.set_state(tieInter.STATE_OUTPUT)

func interTalk(x):
	tieInter.reset()
	tieInter.NPCid("Example")
	tieInter.set_color(Color(1,1,1))
	tieInter.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
	tieInter.buff_typesound("res://addons/GodotTIE/Generic.wav")
	tieInter.buff_text(x, 0.1)
	tieInter.set_state(tieInter.STATE_OUTPUT)
