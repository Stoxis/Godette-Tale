extends Panel

onready var choice : int = 1
onready var currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
onready var isActive : bool = false
onready var ranOnce : bool = false
onready var cellisActive : bool = false
onready var itemisActive : bool = false
onready var statisActive : bool = false
onready var cellphoneEntryScene = load("res://Prefabs/_Cellphone.tscn")
onready var tempIteration : int = 0
onready var tempNode

func _ready():
	$Name.text = globalVariables.Name
	$Level/LevelValue.text = str(globalVariables.Love)
	#$Hitpoints/HitpointsValue = globalVariables.Hitpoints # variable doesn't exist yet
	#$Gold/GoldValue = globalVariables.Gold # variable doesn't exist yet
	for item in globalVariables.cellList:
		tempIteration += 1
		var cellphoneEntry = cellphoneEntryScene.instance()
		$cellMenu/VBoxContainer.add_child(cellphoneEntry, true)
		tempNode = get_node("cellMenu/VBoxContainer/Option " + str(tempIteration))
		tempNode.text = item
	#print(globalVariables.cellList)

func UpdateMenuInformation():
	$Name.text = globalVariables.Name
	$Level/LevelValue.text = str(globalVariables.Love)
	#$Hitpoints/HitpointsValue = globalVariables.Hitpoints # variable doesn't exist yet
	#$Gold/GoldValue = globalVariables.Gold # variable doesn't exist yet

func _on_buff_signal_activated(s):
	if s == "openSavePanel":
		UpdateMenuInformation()

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
		$"menuPanel/Option 1/Cursor".show()
	elif Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && itemisActive && !statisActive: #if the item menu is open close it
		$itemMenu.hide() #close the item menu
		itemisActive = false
		choice = 1
		$"menuPanel/Option 1/Cursor".show()
	elif Input.is_action_just_pressed("open_menu") && isActive && !cellisActive && !itemisActive && statisActive: #if the stats menu is open close it
		$statMenu.hide() #close the stats menu
		statisActive = false
		choice = 1
		$"menuPanel/Option 1/Cursor".show()
	elif Input.is_action_just_pressed("open_menu") && !isActive && !cellisActive && !itemisActive && !statisActive: #if no menus are open open the main menu
		choice = 1
		$"menuPanel/Option 1/Cursor".show()
		$"menuPanel/Option 2/Cursor".hide()
		$"menuPanel/Option 3/Cursor".hide()
		self.show() #open the menu
		isActive = true
		ranOnce = false
		globalVariables.menuOpen = true
	if Input.is_action_just_pressed("move_up") && isActive && !cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("move_down") && isActive && !cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && !cellisActive && !itemisActive && !statisActive:
		currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
		if ev.scancode == KEY_UP: # If up arrow is pressed
			if choice != 1:
				currentChoice.hide()
				choice -= 1
				currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 3
				currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_DOWN: # If down arrow is pressed
			if choice != 3:
				currentChoice.hide()
				choice += 1
				currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 1
				currentChoice = get_node("menuPanel/Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_C:
			#print("You chose: nothing")
			isActive = false 
			self.hide()
			pass
		else: # If Enter is pressed
			if choice == 1 || choice == 2: # Placeholder for ITEM and STAT
				#print("You chose: " + str(choice))
				isActive = false 
				self.hide()
			if choice == 3: # Open cellphone menu
				$cellMenu.show()
				choice = 1
				currentChoice.hide()
				currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
				cellisActive = true
				if tempNode != null:
					get_node("cellMenu/VBoxContainer/Option 1/Cursor").show()
	if Input.is_action_just_pressed("move_up") && isActive && cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("move_down") && isActive && cellisActive && !itemisActive && !statisActive || Input.is_action_just_pressed("interact") && isActive && cellisActive && !itemisActive && !statisActive:
		if tempIteration > 3:
			currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
			if ev.scancode == KEY_UP: # If up arrow is pressed
				if choice != 1:
					currentChoice.hide()
					choice -= 1
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
				else:
					currentChoice.hide()
					choice = 3
					currentChoice = get_node("cellMenu/VBoxContainer/Option " + str(choice) + "/Cursor")
					currentChoice.show()
			elif ev.scancode == KEY_DOWN: # If down arrow is pressed
				if choice != 3:
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
					signalManager.emit_signal("cell",globalVariables.cellList[choice])# emit cellphone label name to initiate conversation
					$cellMenu.hide()
					cellisActive = false
					isActive = false
					#print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				ranOnce = true
		elif tempIteration == 2:
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
					#print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				ranOnce = true
		elif tempIteration == 1:
			if ev.scancode == KEY_ENTER: # If enter is pressed
				if ranOnce == true:
					currentChoice.hide()
					signalManager.emit_signal("cell",globalVariables.cellList[0])#emit cellphone label name
					$cellMenu.hide()
					cellisActive = false
					isActive = false
					#print(globalVariables.cellList[choice])
					choice = 1
					ranOnce = false
				ranOnce = true
		elif tempIteration == 0:
			pass
