extends Panel

onready var choice : int = 1
onready var mainMenuchoice : int = 1
onready var currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
onready var isActive : bool = false
onready var ranOnce : bool = false
onready var cellisActive : bool = false
onready var itemisActive : bool = false
onready var itempromptisActive : bool = false
onready var statisActive : bool = false
onready var menuEntryScene = load("res://Prefabs/_MenuEntry.tscn")
onready var cellCount : int = 0
onready var itemCount: int = 0
onready var tempSlot: int = 0
onready var tempItemID: int = 0
onready var tempNodeItem
onready var tempNodeCell

func _ready():
	signalManager.connect("buff_signal", self, "_on_buff_signal_activated")
	$Name.text = globalVariables.Name
	$Level/LevelValue.text = str(globalVariables.Love)
	$Gold/GoldValue.text = str(globalVariables.Gold)
	for item in globalVariables.cellList: #Initialize cellphone
		cellCount += 1
		var menuEntry = menuEntryScene.instance()
		$cellMenu/VBoxContainer.add_child(menuEntry, true)
		tempNodeCell = get_node("cellMenu/VBoxContainer/Option " + str(cellCount))
		#print(tempNodeCell)
		tempNodeCell.text = item
	#print(globalVariables.cellList)
	for item in globalVariables.Items: #Initialize inventory
		itemCount += 1
		var menuEntry = menuEntryScene.instance()
		$itemMenu/VBoxContainer.add_child(menuEntry, true)
		tempNodeItem = get_node("itemMenu/VBoxContainer/Option " + str(itemCount))
		#print(tempNodeItem)
		tempNodeItem.text = itemLibrary.itemDictionary[item].itemName
	#print(globalVariables.Items)
	if globalVariables.Items.size() == 0: #color menu text gray
		$"menuPanel/Option 1".add_color_override("font_color", Color(0.35,0.35,0.35))
	elif globalVariables.Items.size() > 0: #color menu text white
		$"menuPanel/Option 1".add_color_override("font_color", Color(1,1,1))

func UpdateMenuInformation():
	$Name.text = globalVariables.Name
	$Level/LevelValue.text = str(globalVariables.Love)
	#$Hitpoints/HitpointsValue = globalVariables.Hitpoints
	$Gold/GoldValue.text = str(globalVariables.Gold)
	itemCount = 0
	for child in $itemMenu/VBoxContainer.get_children():
		$itemMenu/VBoxContainer.remove_child(child)
		child.queue_free()
	for item in globalVariables.Items: #Update inventory
		itemCount += 1
		var menuEntry = menuEntryScene.instance()
		#menuEntry.set_name("Option " + str(itemCount))
		$itemMenu/VBoxContainer.add_child(menuEntry, true)
		tempNodeItem = get_node("itemMenu/VBoxContainer/Option " + str(itemCount))
		print(tempNodeItem)
		tempNodeItem.text = itemLibrary.itemDictionary[item].itemName
	print(globalVariables.Items)
	if globalVariables.Items.size() == 0: #color menu text gray
		$"menuPanel/Option 1".add_color_override("font_color", Color(0.35,0.35,0.35))
	elif globalVariables.Items.size() > 0: #color menu text white
		$"menuPanel/Option 1".add_color_override("font_color", Color(1,1,1))
		

func _on_buff_signal_activated(s):
	print(s)
	if s == "openSavePanel":
		UpdateMenuInformation()
	if s == "closeMenuPanel":
		self.hide() #close the main menu
		isActive = false
		globalVariables.menuOpen = false
		globalVariables.disableMenu = false

func _on_save_update_activated():
	UpdateMenuInformation()

func _input(ev):
	if Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && !itemisActive && !statisActive: #if the main menu is all that is open close the main menu
		self.hide() #close the main menu
		isActive = false
		globalVariables.menuOpen = false
	elif Input.is_action_just_pressed("open_menu") && isActive && cellisActive && !itemisActive && !statisActive: #if the cellphone menu is open close it
		ranOnce = false
		$cellMenu.hide() #close the cellphone menu
		cellisActive = false
		choice = 1
		get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor").show()
	elif Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && itemisActive && !itempromptisActive && !statisActive: #if the item menu is open close it
		$itemMenu.hide() #close the item menu
		currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
		currentChoice.hide()
		itemisActive = false
		choice = 1
		get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor").show()
		ranOnce = false
	elif Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && itemisActive && itempromptisActive && !statisActive: #if the item menu is open close it
		currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
		currentChoice.hide() #back out of the item prompt
		itempromptisActive = false
		if globalVariables.Items.size() != 0:
			print("item menu shown")
			print("item array size: " + str(globalVariables.Items.size()))
			$itemMenu.show()
			choice = 1
			currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			currentChoice.show()
			itemisActive = true
			if tempNodeItem != null:
				get_node("itemMenu/VBoxContainer/Option 1/Cursor").show()
		
	elif Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && !itemisActive && statisActive: #if the stats menu is open close it
		$statMenu.hide() #close the stats menu
		statisActive = false
		choice = 1
		get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor").show()
	elif Input.is_action_just_pressed("open_menu") && !isActive && !cellisActive && !itemisActive && !statisActive && !globalVariables.disableMenu: #if no menus are open open the main menu
		mainMenuchoice = 1
		choice = 1
		$"menuPanel/Option 1/Cursor".show()
		$"menuPanel/Option 2/Cursor".hide()
		$"menuPanel/Option 3/Cursor".hide()
		self.show() #open the menu
		isActive = true
		ranOnce = false
		globalVariables.menuOpen = true
	if Input.is_action_just_pressed("move_up") && isActive && !cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("move_down") && isActive && !cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && !cellisActive && !itemisActive && !statisActive: #main menu interactions
		currentChoice = get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor")
		if ev.scancode == KEY_UP: # If up arrow is pressed
			if mainMenuchoice != 1:
				currentChoice.hide()
				mainMenuchoice -= 1
				currentChoice = get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				mainMenuchoice = 3
				currentChoice = get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_DOWN: # If down arrow is pressed
			if mainMenuchoice != 3:
				currentChoice.hide()
				mainMenuchoice += 1
				currentChoice = get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				mainMenuchoice = 1
				currentChoice = get_node("menuPanel/Option " + str(mainMenuchoice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_C:
			print("You chose: nothing")
			isActive = false 
			self.hide()
			pass
		else: # If Enter is pressed
			if mainMenuchoice == 1 && globalVariables.Items.size() != 0 && !globalVariables.disableMenu:
				print("item menu shown")
				print("item array size: " + str(globalVariables.Items.size()))
				$itemMenu.show()
				choice = 1
				currentChoice.hide()
				currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(mainMenuchoice) + "/Cursor")
				currentChoice.show()
				itemisActive = true
				if tempNodeItem != null:
					get_node("itemMenu/VBoxContainer/Option 1/Cursor").show()
			if mainMenuchoice == 2 && !globalVariables.disableMenu:
				print("You chose: " + str(mainMenuchoice))
				isActive = false 
				self.hide()
			if mainMenuchoice == 3 && !globalVariables.disableMenu:
				print("cell menu shown")
				$cellMenu.show()
				choice = 1
				currentChoice.hide()
				currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(mainMenuchoice) + "/Cursor")
				cellisActive = true
				if tempNodeCell != null:
					get_node("cellMenu/VBoxContainer/Option 1/Cursor").show()
	if Input.is_action_just_pressed("move_up") && isActive && cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("move_down") && isActive && cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && cellisActive && !itemisActive && !statisActive: #cell menu interactions
		if globalVariables.cellList.size() >= 3:
			currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			if ev.scancode == KEY_UP: # If up arrow is pressed
				if choice != 1:
					currentChoice.hide()
					choice -= 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = globalVariables.cellList.size()
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_DOWN: # If down arrow is pressed
				if choice != globalVariables.cellList.size():
					currentChoice.hide()
					choice += 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					choice -= 1
					signalManager.emit_signal("cell",globalVariables.cellList[choice])#emit cellphone label name
					$cellMenu.hide()
					cellisActive = false
					isActive = false
					print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.cellList.size() == 2:
			currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			if ev.scancode == KEY_UP: # If up arrow is pressed
				if choice == 1:
					currentChoice.hide()
					choice = 2
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_DOWN: # If down arrow is pressed
				if choice == 2:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 2
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					choice -= 1
					signalManager.emit_signal("cell",globalVariables.cellList[choice])#emit cellphone label name
					$cellMenu.hide()
					cellisActive = false
					isActive = false
					print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.cellList.size() == 1:
			if ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					signalManager.emit_signal("cell",globalVariables.cellList[0])#emit cellphone label name
					$cellMenu.hide()
					cellisActive = false
					isActive = false
					print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.cellList.size() == 0:
			pass
	if Input.is_action_just_pressed("move_up") && isActive && !cellisActive && itemisActive && !itempromptisActive && !statisActive || Input.is_action_just_pressed("move_down") && isActive && !cellisActive && itemisActive && !itempromptisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && !cellisActive && itemisActive && !itempromptisActive && !statisActive: #item menu interactions
		if globalVariables.Items.size() >= 3:
			currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			if ev.scancode == KEY_UP: # If up arrow is pressed
				if choice != 1:
					currentChoice.hide()
					choice -= 1
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = globalVariables.Items.size()
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_DOWN: # If down arrow is pressed
				if choice != globalVariables.Items.size():
					currentChoice.hide()
					choice += 1
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					tempSlot = choice
					choice -= 1
					tempItemID = globalVariables.Items[choice]
					#$itemMenu.hide()
					#itemisActive = false
					itempromptisActive = true
					#isActive = false
					print("ItemID: " + str(globalVariables.Items[choice]) + "\nInventory slot: " + str(tempSlot))
					choice = 1
					currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
					currentChoice.show()
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.Items.size() == 2:
			currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			if ev.scancode == KEY_UP: # If up arrow is pressed
				if choice == 1:
					currentChoice.hide()
					choice = 2
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_DOWN: # If down arrow is pressed
				if choice == 2:
					currentChoice.hide()
					choice = 1
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 2
					currentChoice = get_node("itemMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					tempSlot = choice
					choice -= 1
					tempItemID = globalVariables.Items[choice]
					#$itemMenu.hide()
					#itemisActive = false
					itempromptisActive = true
					#isActive = false
					print("ItemID: " + str(globalVariables.Items[choice]) + "\nInventory slot: " + str(tempSlot))
					choice = 1
					currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
					currentChoice.show()
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.Items.size() == 1:
			if ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					tempSlot = choice
					choice -= 1
					tempItemID = globalVariables.Items[choice]
					#$itemMenu.hide()
					#itemisActive = false
					itempromptisActive = true
					#isActive = false
					print("ItemID: " + str(globalVariables.Items[choice]) + "\nInventory slot: " + str(tempSlot))
					choice = 1
					currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
					currentChoice.show()
					ranOnce = false
				else:
					ranOnce = true
		elif globalVariables.Items.size() == 0:
			pass
#################################################################################################################################### EXPERIMENTAL
	if Input.is_action_just_pressed("move_left") && isActive && !cellisActive && itemisActive && itempromptisActive && !statisActive || Input.is_action_just_pressed("move_right") && isActive && !cellisActive && itemisActive && itempromptisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && !cellisActive && itemisActive && itempromptisActive && !statisActive: #item prompt interactions
		currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
		if ev.scancode == KEY_LEFT: # If left arrow is pressed
			if choice != 1:
				currentChoice.hide()
				choice -= 1
				currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 3
				currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_RIGHT: # If right arrow is pressed
			if choice != 3:
				currentChoice.hide()
				choice += 1
				currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 1
				currentChoice = get_node("itemMenu/Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_ENTER && choice == 1: # USE
			if ranOnce == true:
				print("Item use")
				print(str(itemLibrary.itemDictionary[tempItemID].itemDescription))
				globalVariables.disableMenu = true
				itemLibrary.itemFunction(itemLibrary.itemDictionary[tempItemID].itemDescription) #add use code here
				$itemMenu.hide()
				isActive = false
				itemisActive = false
				itempromptisActive = false
				currentChoice.hide()
				ranOnce = false
			else:
				ranOnce = true
		elif ev.scancode == KEY_ENTER && choice == 2: # INFO
			if ranOnce == true:
				print("Item info")
				print(str(itemLibrary.itemDictionary[tempItemID].itemDescription))
				globalVariables.disableMenu = true
				itemLibrary.itemFunction(itemLibrary.itemDictionary[tempItemID].itemDescription) #add use code here
				$itemMenu.hide()
				isActive = false
				itemisActive = false
				itempromptisActive = false
				currentChoice.hide()
				ranOnce = false
			else:
				ranOnce = true
		elif ev.scancode == KEY_ENTER && choice == 3: # DROP
			if ranOnce == true:
				print("Item drop")
				print(str(itemLibrary.itemDictionary[tempItemID].itemDescription))
				globalVariables.Items.remove(tempSlot-1)
				UpdateMenuInformation()
				globalVariables.disableMenu = true
				if itemLibrary.itemDictionary[tempItemID].has("itemDropText"):
					itemLibrary.itemFunction(itemLibrary.itemDictionary[tempItemID].itemDropText)
				else:
					itemLibrary.itemFunction(["The " + itemLibrary.itemDictionary[tempItemID].itemName + " was thrown away."])
				$itemMenu.hide()
				isActive = false
				itemisActive = false
				itempromptisActive = false
				currentChoice.hide()
				ranOnce = false
			else:
				ranOnce = true

			#$"menuPanel/Option 1".hide() #ITEM
			#$"menuPanel/Option 2".hide() #STAT
			#$"menuPanel/Option 3".hide() #CELL
			#pass
			#emit_signal("player_choice", outputBranch, get_node("Option " + str(choice)).text)
			#send signal
		#print("Active: " + str(optionsActive) + "\nDisabled: " + str(optionsDisabled))
		#called everytime enter/left/right is pressed while isActive
