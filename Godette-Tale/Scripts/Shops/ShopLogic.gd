extends Panel

# I coded it so you can change max inventory size in globalVariables and 
# everything will work, you might need to change font-size, change the
# sellElementPerColumn or make the menu panel bigger for it to look good
# but no errors/crashes will occur if you make the inventory larger.

# Don't change any of these variables unless you know what you're doing
onready var disableMenu : bool = false # Used by the shop talk menu during dialogue
onready var choice : int = 1
onready var choiceRtn : int
onready var choiceSize : int = 4
onready var loopCount : int = 0
onready var tempNode
onready var currentChoice = get_node("Option " + str(choice) + "/Cursor")
onready var menuEntryScene = load("res://Prefabs/_MenuEntry.tscn")
onready var sellOptionsScene = load("res://Prefabs/_SellOptions.tscn")
onready var maxInventorySize = globalVariables.inventorySize

# Sell Variables
# You can change soldLabel and SellElementPerColumn in the root node of the shop, the rest are used by the code.
onready var soldLabel : String = get_node("/root/Root_Node").soldLabel #What is displayed in lieu of an item after you sell it
onready var sellElementPerColumn : int = get_node("/root/Root_Node").sellElementPerColumn # This changes many inventory items are displayed per colunm in the sell menu
onready var sellColumnsSize : int
onready var sellColumnsChoice : int = 1
onready var sellChoice : int = 0 # This gives you a number that is compatible with the index of the globalVariables.Items[] array
onready var sellElementsPerColumnSize : float
onready var lastSellColumnSize : int
onready var soldItems : Array = globalVariables.Items.duplicate()

# Menu Variables 
# You can change the isSelling variable in the root node of the shop to Disable or Enable the sell menu.
onready var choiceExtend : String = ""
onready var choiceExtendCopy : String = ""
onready var talkActive : bool = false
onready var isSelling : bool = get_node("/root/Root_Node").isSelling

func _ready():
	$"../InterPanel/sellGrid".columns = int(ceil(float(maxInventorySize)/sellElementPerColumn))
	get_node("Gold").text = str(globalVariables.Gold) + "G"
	get_node("Space").text = str(globalVariables.Items.size()) + "/" + str(maxInventorySize)
	for item in globalVariables.talkList: #Initialize talk choices
		loopCount += 1
		var menuEntry = menuEntryScene.instance()
		$"../InterPanel/talkOptions".add_child(menuEntry, true)
		tempNode = get_node("../InterPanel/talkOptions/Option " + str(loopCount))
		tempNode.text = item
	loopCount = 0
	for item in globalVariables.shopInventory: #Initialize buy choices
		loopCount += 1
		var menuEntry = menuEntryScene.instance()
		$"../InterPanel/buyOptions".add_child(menuEntry, true)
		tempNode = get_node("../InterPanel/buyOptions/Option " + str(loopCount))
		tempNode.text = str(itemLibrary.itemDictionary[item].buyPrice) + "G - " + itemLibrary.itemDictionary[item].itemName	

func updateSellMenu():
	if globalVariables.Items.size() > 0: # If you have more than 0 items
		loopCount = soldItems.size()-1
		while loopCount != -1:
			if str(soldItems[loopCount]) == "SOLD_ITEM":
				globalVariables.Items.remove(loopCount) # remove sold items from inventory
			loopCount -= 1
		soldItems = globalVariables.Items.duplicate()
	loopCount = 0
	var loopCountToFive = 0
	for item in soldItems: #Initialize buy choices
		loopCount += 1
		loopCountToFive += 1
		if get_node_or_null("../InterPanel/sellGrid/sellOptions " + str(ceil(float(loopCount)/sellElementPerColumn))) == null:
			var sellOptionsEntry = sellOptionsScene.instance()
			get_node("../InterPanel/sellGrid").add_child(sellOptionsEntry, true)
			loopCountToFive = 1
		var menuEntry = menuEntryScene.instance()
		get_node("../InterPanel/sellGrid/sellOptions " + str(ceil(float(loopCount)/sellElementPerColumn))).add_child(menuEntry, true)
		tempNode = get_node("../InterPanel/sellGrid/sellOptions " + str(ceil(float(loopCount)/sellElementPerColumn)) + "/Option " + str(loopCountToFive))
		if str(item) != "SOLD_ITEM": #item isn't sold
			tempNode.text = str(itemLibrary.itemDictionary[item].sellPrice) + "G - " + itemLibrary.itemDictionary[item].itemName	
		else: #item is sold
			tempNode.text = soldLabel
			tempNode.add_color_override("font_color", Color(0.35,0.35,0.35))
	sellColumnsSize = get_node("../InterPanel/sellGrid").get_child_count()
	sellElementsPerColumnSize = floor(globalVariables.Items.size()/sellElementPerColumn)
	lastSellColumnSize = globalVariables.Items.size()-(sellElementPerColumn*sellElementsPerColumnSize)

func updateChoice(upDownLeftRight, maxOptions):
	if currentChoice != null:
		currentChoice.hide()
	if sellColumnsChoice == sellColumnsSize && "sellGrid" in choiceExtend:
		if upDownLeftRight == "up":
			if choice == 1:
				choice = lastSellColumnSize
			else:
					choice -= 1
		if upDownLeftRight == "down":
			if choice == lastSellColumnSize:
				choice = 1
			else:
				choice += 1
	else:
		if upDownLeftRight == "up":
			if choice == 1:
				choice = maxOptions
			else:
					choice -= 1
		if upDownLeftRight == "down":
			if choice == maxOptions:
				choice = 1
			else:
				choice += 1
	#changeMenu(choiceRtn, globalVariables.Items.size(), "../InterPanel/sellGrid/sellOptions " + str(sellColumnsChoice) + "/")
	if upDownLeftRight == "left" && choiceExtend == "../InterPanel/SellOptionHBox/":
		if choice == 1:
			choice = 2
		else:
			choice -= 1
	if upDownLeftRight == "right" && choiceExtend == "../InterPanel/SellOptionHBox/":
		if choice == 2:
			choice = 1
		else:
			choice += 1
	if upDownLeftRight == "left" && choiceExtendCopy == "../InterPanel/sellGrid/sellOptions ":
		if sellColumnsChoice == 1:
			sellColumnsChoice = sellColumnsSize
		else:
			sellColumnsChoice -= 1
		choiceExtend = choiceExtendCopy + str(sellColumnsChoice) + "/"
	if upDownLeftRight == "right" && choiceExtendCopy == "../InterPanel/sellGrid/sellOptions ":
		if sellColumnsChoice == sellColumnsSize:
			sellColumnsChoice = 1
		else:
			sellColumnsChoice += 1
		choiceExtend = choiceExtendCopy + str(sellColumnsChoice) + "/"
	currentChoice = get_node_or_null(choiceExtend + "Option " + str(choice) + "/Cursor")
	if currentChoice != null:
		currentChoice.show()
	else:
		sellColumnsChoice -= 1
		choiceExtend = choiceExtendCopy + str(sellColumnsChoice) + "/"
		currentChoice = get_node_or_null(choiceExtend + "Option " + str(choice) + "/Cursor")
		if currentChoice != null:
			currentChoice.show()

func shopButtonVisiblity(x):
	if x == false:
		get_node("Option 1").hide()
		get_node("Option 2").hide()
		get_node("Option 3").hide()
		get_node("Option 4").hide()
	if x == true:
		get_node("Option 1").show()
		get_node("Option 2").show()
		get_node("Option 3").show()
		get_node("Option 4").show()

func changeMenu(goToChoice, choiceSizeInt, choiceNode):
	currentChoice.hide()
	choiceSize = choiceSizeInt
	choiceExtend = choiceNode
	choiceExtendCopy = choiceNode.rstrip("0123456789/")
	choice = goToChoice
	currentChoice = get_node(choiceExtend + "Option " + str(choice) + "/Cursor")
	get_node(choiceExtend + "Option " + str(choice) + "/Cursor").show()

func infoTextGen():
	var infoTextData : String = ""
	var currentItem = itemLibrary.itemDictionary[globalVariables.shopInventory[(choice-1)]]
	match(itemLibrary.itemDictionary[globalVariables.shopInventory[(choice-1)]].itemType):
		0: # Key item
			infoTextData = currentItem.shopDescription
		1: # Consumable Item
			infoTextData = currentItem.shopDescription
		2: # Weapon
			infoTextData = "Weapon: " + str(currentItem.itemAttack) + "AT\n(" + str(currentItem.itemAttack-globalVariables.PlayerAT) + "AT)\n" + currentItem.shopDescription
		3: # Armor
			infoTextData = "Armor: " + str(currentItem.itemDefence) + "DF\n(" + str(currentItem.itemDefence-globalVariables.PlayerDF) + "DF)\n" + currentItem.shopDescription
	return infoTextData
# Buy
# Sell
# Talk
# Exit

func _input(ev):
	if !disableMenu:
		if Input.is_action_just_pressed("move_up") || Input.is_action_just_pressed("move_down") || Input.is_action_just_pressed("move_right") || Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("interact") || Input.is_action_just_pressed("open_menu"): # menu interactions
			if ev.scancode == KEY_UP && choiceExtendCopy != "../InterPanel/SellOptionHBox": # If up arrow is pressed
				updateChoice("up", choiceSize)
				if choiceExtend == "../InterPanel/buyOptions/":
					get_node("../../Root_Node").infoText(infoTextGen())
			elif ev.scancode == KEY_DOWN && choiceExtendCopy != "../InterPanel/SellOptionHBox": # If down arrow is pressed
				updateChoice("down", choiceSize)
				if choiceExtend == "../InterPanel/buyOptions/":
					get_node("../../Root_Node").infoText(infoTextGen())
			elif ev.scancode == KEY_DOWN:
				pass
			elif ev.scancode == KEY_UP:
				pass
			elif ev.scancode == KEY_LEFT: # If left arrow is pressed
				if choiceExtendCopy == "../InterPanel/sellGrid/sellOptions " || choiceExtendCopy == "../InterPanel/SellOptionHBox":
					updateChoice("left", sellColumnsSize)
			elif ev.scancode == KEY_RIGHT: # If right arrow is pressed
				if choiceExtendCopy == "../InterPanel/sellGrid/sellOptions " || choiceExtendCopy == "../InterPanel/SellOptionHBox":
					updateChoice("right", sellColumnsSize)
			elif ev.scancode == KEY_C: # kind of like a back button
				if choiceExtend != "":
					get_node("../../Root_Node").clear()
				if choiceExtend == "../InterPanel/buyOptions/": # Exit Buy Menu
					$InfoPanel.disappear()
					shopButtonVisiblity(true)
					get_node("../InterPanel/buyOptions").hide()
					changeMenu(1, 4, "")
					get_node("../../Root_Node").rtrnGreeting()
				elif choiceExtendCopy == "../InterPanel/sellGrid/sellOptions ": # Exit Sell Menu
					shopButtonVisiblity(true)
					self.show_behind_parent = false
					sellChoice = 0
					sellColumnsChoice = 1
					lastSellColumnSize = 0
					sellColumnsSize = 0
					get_node("../InterPanel/sellGrid").hide()
					changeMenu(2, 4, "")
					get_node("../../Root_Node").rtrnGreeting()
					for n in get_node("../InterPanel/sellGrid").get_children():
						get_node("../InterPanel/sellGrid").remove_child(n)
						n.queue_free()
					updateSellMenu()
					get_node("Space").text = str(globalVariables.Items.size()) + "/" + str(maxInventorySize)
				elif choiceExtend == "../InterPanel/talkOptions/": # Exit Talk Menu
					shopButtonVisiblity(true)
					get_node("../InterPanel/talkOptions").hide()
					changeMenu(3, 4, "")
					get_node("../../Root_Node").rtrnGreeting()
				elif choiceExtend == "ConfirmPrompt/": # Exit confirmprompt Menu
					changeMenu(choiceRtn, globalVariables.shopInventory.size(), "../InterPanel/buyOptions/")
					choiceRtn = 0
					get_node("ConfirmPrompt").hide()
					get_node("../../Root_Node").rtrnBuyGreet()
			else: #enter is pressed
				get_node("../../Root_Node").clear()
				if choice == 1 && choiceExtend == "": # Buy Menu
					$InfoPanel.appear()
					get_node("../InterPanel/buyOptions").show()
					shopButtonVisiblity(false)
					changeMenu(1, globalVariables.shopInventory.size(), "../InterPanel/buyOptions/")
					get_node("../../Root_Node").infoText(infoTextGen())
					get_node("../../Root_Node").buyGreet()
				elif choice == 2 && choiceExtend == "": # Sell Menu
					if isSelling && globalVariables.Items.size() > 0: # if selliing and has items
						for n in get_node("../InterPanel/sellGrid").get_children():
							get_node("../InterPanel/sellGrid").remove_child(n)
							n.queue_free()
						updateSellMenu()
						get_node("../InterPanel/sellGrid").show()
						shopButtonVisiblity(false)
						if sellElementPerColumn <= globalVariables.Items.size():
							changeMenu(1, sellElementPerColumn, "../InterPanel/sellGrid/sellOptions 1/")
						else:
							changeMenu(1, globalVariables.Items.size(), "../InterPanel/sellGrid/sellOptions 1/")
						sellChoice = 0
						self.show_behind_parent = true
					elif isSelling && globalVariables.Items.size() == 0: # if selling but inventory empty
						get_node("../../Root_Node").noItemsToSell() # dialogue saying inventory empty
					else: # if not selling
						get_node("../../Root_Node").notSelling() # dialogue saying not selling
				elif choice == 3 && choiceExtend == "": # Talk Menu
					get_node("../InterPanel/talkOptions").show()
					shopButtonVisiblity(false)
					changeMenu(1, globalVariables.talkList.size(), "../InterPanel/talkOptions/")
					get_node("../../Root_Node").talkGreet()
				elif choice == 4 && choiceExtend == "": # Exit Menu
					SceneChanger.change_scene(globalVariables.exitShopScene, globalVariables.exitShopPosition, "fade")
					globalVariables.exitingShop = true
				elif choiceExtend == "../InterPanel/talkOptions/": # Initiate dialogue
					choice -= 1
					signalManager.emit_signal("talk",globalVariables.talkList[choice])
					choice += 1
					disableMenu = true
					self.hide()
				elif choiceExtend == "../InterPanel/buyOptions/": # Open Buy confirm prompt
					choiceRtn = choice
					get_node("ConfirmPrompt").text = "Buy it for\n" + str(itemLibrary.itemDictionary[globalVariables.shopInventory[(choice-1)]].buyPrice) + "G?"
					changeMenu(1, 2, "ConfirmPrompt/")
					get_node("ConfirmPrompt").show()
				elif choiceExtend == "ConfirmPrompt/": # Buy confirmprompt yes or no selected
					if choice == 1: # Buy confirmprompt Yes selected
						if itemLibrary.itemDictionary[globalVariables.shopInventory[(choiceRtn-1)]].buyPrice <= globalVariables.Gold:
							if globalVariables.Items.size() < globalVariables.inventorySize: # If you have enough gold and inventory space
								get_node("../../Root_Node").buyReact("Item purchased")
								globalVariables.Items.append(globalVariables.shopInventory[(choiceRtn-1)])
								soldItems.append(globalVariables.shopInventory[(choiceRtn-1)])
								globalVariables.Gold -= itemLibrary.itemDictionary[globalVariables.shopInventory[(choiceRtn-1)]].buyPrice
								get_node("BuySound").play()
								get_node("Gold").text = str(globalVariables.Gold) + "G"
								get_node("Space").text = str(globalVariables.Items.size()) + "/" + str(globalVariables.inventorySize)
							else: # Not enough inventory
								get_node("../../Root_Node").buyReact("Not enough inventory")
						else: # Not enough gold
							get_node("../../Root_Node").buyReact("Not enough gold")
					if choice == 2: # Buy confirmprompt No selected
						get_node("../../Root_Node").rtrnBuyGreet()
					get_node("ConfirmPrompt").hide()	
					changeMenu(choiceRtn, globalVariables.shopInventory.size(), "../InterPanel/buyOptions/")
				elif choiceExtendCopy == "../InterPanel/sellGrid/sellOptions ": # Sell confirm prompt
					if get_node_or_null(choiceExtend + "Option " + str(choice)).text != soldLabel: # If item not sold
						choiceRtn = choice
						sellChoice = (sellColumnsChoice - 1) * sellElementPerColumn + choiceRtn-1 # generate index of current sell choice
						get_node("../InterPanel/SellLabelHBox/SellConfirmLabel").text = "Sell " + str(itemLibrary.itemDictionary[globalVariables.Items[sellChoice]].itemName) + " for " + str(itemLibrary.itemDictionary[globalVariables.Items[sellChoice]].sellPrice) + "G?"
						changeMenu(1, 2, "../InterPanel/SellOptionHBox/")
						get_node("../InterPanel/SellOptionHBox").show()
						get_node("../InterPanel/SellLabelHBox").show()
						get_node("../InterPanel/sellGrid").hide()
				elif choiceExtend == "../InterPanel/SellOptionHBox/": # Sell rompt yes or no selected
					if choice == 1: # sell confirmprompt Yes selected
						get_node("BuySound").play()
						soldItems[sellChoice] = "SOLD_ITEM"
						globalVariables.Gold += itemLibrary.itemDictionary[globalVariables.Items[sellChoice]].sellPrice
						get_node("Gold").text = str(globalVariables.Gold) + "G"
						get_node("../InterPanel/sellGrid/sellOptions " + str(sellColumnsChoice) + "/Option " + str(choiceRtn)).text = soldLabel
						get_node("../InterPanel/sellGrid/sellOptions " + str(sellColumnsChoice) + "/Option " + str(choiceRtn)).add_color_override("font_color", Color(0.35,0.35,0.35))
					#if choice == 2: # sell confirmprompt No selected (haggle code here)
					get_node("../InterPanel/SellOptionHBox").hide()
					get_node("../InterPanel/SellLabelHBox").hide()
					get_node("../InterPanel/sellGrid").show()
					shopButtonVisiblity(false)
					changeMenu(choiceRtn, sellElementPerColumn, "../InterPanel/sellGrid/sellOptions " + str(sellColumnsChoice) + "/")
					choiceRtn = 0
					self.show_behind_parent = true
