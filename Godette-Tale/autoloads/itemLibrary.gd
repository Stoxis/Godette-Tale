extends Node
var tie : Node
var dialogue : Node
# This node exists solely to list all possible items in the game
# Having an item dictionary system reduces game size and complexity 
# by referencing the same code instead of every new item entry being
# considered completely unique

#itemType
#0 = key
#1 = consumable
#2 = weapon
#3 = armor

const itemDictionary = {
	0: {
		"itemType": 1,
		"itemName": "Bisicle",
		"itemDescription": ["* \"Bisicle\" Heals 11 HP\n* It's a two-pronged popsicle,\nso you can eat it twice."],
		"shopDescription": "Heals 11HP x 2\nEat it twice!",
		"nShort": "Bisicle",
		"Heal": 11,
		"buyPrice": 15,
		"sellPrice": 5
	},
	1: {
		"itemType": 1,
		"itemName": "Unisicle",
		"itemDescription": ["* \"Unisicle\" Heals 11 HP\n* It's a SINGLE-pronged popsicle. Wait, that's just normal..."],
		"shopDescription": "Heals 11HP x 1\nOne and done!",
		"nShort": "Unisicle",
		"nSerious": "Popsicle",
		"Heal": 11,
		"buyPrice": 8,
		"sellPrice": 3
	},
	2: {
		"itemType": 2,
		"itemName": "Stick",
		"itemDescription": ["* Stick","(happy dog noises)"],
		"shopDescription": "A stick.",
		"itemDropText": ["* Fetch","(happy dog noises)"],
		"itemAttack": 0,
		"buyPrice": 0,
		"sellPrice": 150
	},
	3: {
		"itemType": 1,
		"itemName": "Bandage",
		"itemDescription": ["* Bandage"],
		"shopDescription": "Heals 10HP\nFirst-aid\nessential",
		"itemDefence": 0,
		"buyPrice": 5,
		"sellPrice": 150
	}
};

func itemFunction(inputText): #add support for playing different item sounds when an item is used  #add health and remove item, and update inv when an item is used
	if tie != globalVariables.tie:
		tie = globalVariables.tie
		dialogue = globalVariables.dialogue
	if !dialogue.is_visible():
		tie.reset()
		tie.NPCid("")
		tie.portrait_visible(false)
		tie.set_color(Color(1,1,1))
		#tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Text.tres")
		#tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono.tres")
		tie.set_font_bypath("res://addons/GodotTIE/Fonts/DT-Mono-Dialogue.tres")
		tie.buff_typesound("res://addons/GodotTIE/Generic.wav")
		tie.buff_panel("show")
		for item in inputText:
			tie.buff_text(item, 0.055)
			tie.buff_break()
			tie.buff_clear()
		tie.buff_panel("hide")
		tie.buff_signal("closeMenuPanel")
		tie.buff_face("res://Assets/Expressions/None.png")
		tie.set_state(tie.STATE_OUTPUT)
