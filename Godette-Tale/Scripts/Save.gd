extends Panel

onready var choice : int = 1
onready var currentChoice = get_node("Option " + str(choice) + "/Cursor")
onready var isActive : bool = false

func _ready():
	signalManager.connect("buff_signal", self, "_on_buff_signal_activated")
	signalManager.connect("save_update", self, "_on_save_update_activated")

func ShowSavePanelWithSelector():
	$HBoxContainer/Name.text = globalVariables.Name
	$HBoxContainer2/Level.text = "LV"+str(globalVariables.Love)
	$HBoxContainer3/Time.text = globalVariables.previousTimeFormatted
	$Description.text = globalVariables.roomDescription
	$HBoxContainer/Name.add_color_override("font_color", Color(1,1,1))
	$HBoxContainer2/Level.add_color_override("font_color", Color(1,1,1))
	$HBoxContainer3/Time.add_color_override("font_color", Color(1,1,1))
	$Description.add_color_override("font_color", Color(1,1,1))
	$"Option 1".add_color_override("font_color", Color(1,1,1))
	$"Option 1".text = "Save"
	$"Option 1/Cursor".show()
	$"Option 2".show()
	$"Option 2/Cursor".hide()
	self.show()
	isActive = true

func _on_buff_signal_activated(s):
	if s == "openSavePanel":
		ShowSavePanelWithSelector()

func _on_save_update_activated():
	ShowSavePanelWithSelector()

func _input(ev):
	if !isActive && self.is_visible() && Input.is_action_just_pressed("interact"):
		self.hide()
	if isActive && Input.is_action_just_pressed("move_left") || isActive && Input.is_action_just_pressed("move_right") || isActive && Input.is_action_just_pressed("interact"):
		currentChoice = get_node("Option " + str(choice) + "/Cursor")
		if ev.scancode == KEY_LEFT: # If left arrow is pressed
			if choice != 1:
				currentChoice.hide()
				choice -= 1
				currentChoice = get_node("Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 2
				currentChoice = get_node("Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_RIGHT: # If right arrow is pressed
			if choice != 2:
				currentChoice.hide()
				choice += 1
				currentChoice = get_node("Option " + str(choice) + "/Cursor")
				currentChoice.show()
			else:
				currentChoice.hide()
				choice = 1
				currentChoice = get_node("Option " + str(choice) + "/Cursor")
				currentChoice.show()
		else: # If Enter is pressed
			if choice == 1: #Save
				globalVariables.funcSave()
				$AudioStreamPlayer.stream = load("res://Assets/Sound Effects/SavePoint.wav")
				$AudioStreamPlayer.play()
				$HBoxContainer/Name.add_color_override("font_color", Color(1,1,0))
				$HBoxContainer2/Level.add_color_override("font_color", Color(1,1,0))
				$HBoxContainer3/Time.add_color_override("font_color", Color(1,1,0))
				$Description.add_color_override("font_color", Color(1,1,0))
				$"Option 1".add_color_override("font_color", Color(1,1,0))
				$"Option 1".text = "File saved."
				$"Option 1/Cursor".hide()
				$"Option 2".hide()
				$"Option 2/Cursor".hide()
				isActive = false
			if choice == 2: #Return
				self.hide()
				isActive = false
			pass
			#send signal
