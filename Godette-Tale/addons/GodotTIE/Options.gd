extends HBoxContainer

onready var isActive : bool = false

onready var choice : int = 1
onready var currentChoice = get_node("Option " + str(choice) + "/Cursor")
onready var optionsActive : int
onready var optionsDisabled : int
onready var outputBranch : String

signal player_choice(input)

#func _ready():
	#self.show()
	#ShowOptionsWithSelector(4, 0, false, "\n\nForgive", "\n\nDo not", "I've got\nplaces to\nbe", "\nI'm\nReady")

# Show options menu
# outputBranchFunc = This string is output after a choice is made, it's sort of like ID proof that this choice occured.
# OptionsActive = How many selectable options there are
# OptionsDisabled = How many unselectable options there are
# PortraitVisible = Is a character portrait visible or not
func ShowOptionsWithSelector(outputBranchFunc, optionsActiveFunc, optionsDisabledFunc, portraitVisible, option1Text, option2Text, option3Text, option4Text):
	optionsActive = optionsActiveFunc
	optionsDisabled = optionsDisabledFunc
	outputBranch = outputBranchFunc
	var funcchoice : int
	var funcisActive : bool
	if portraitVisible: #changes size based on whether a portrait is visible or not
		self.rect_position = Vector2( 128, 64 )
		self.rect_size = Vector2( 864, 176 )
	else:
		self.rect_position = Vector2( 40, 8 )
		self.rect_size = Vector2( 1040, 288 )
	$"Option 1/Cursor".show()
	$"Option 2/Cursor".hide()
	$"Option 3/Cursor".hide()
	$"Option 4/Cursor".hide()
	self.show()
	if optionsActive == 3 && optionsDisabled == 1:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		$"Option 4".text = option4Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".show()
		$"Option 4".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 2 && optionsDisabled == 2:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		$"Option 4".text = option4Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".show()
		$"Option 3".add_color_override("font_color", Color(0.35,0.35,0.35))
		$"Option 4".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 2 && optionsDisabled == 1:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".hide()
		$"Option 3".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 1 && optionsDisabled == 3:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		$"Option 4".text = option4Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".show()
		$"Option 2".add_color_override("font_color", Color(0.35,0.35,0.35))
		$"Option 3".add_color_override("font_color", Color(0.35,0.35,0.35))
		$"Option 4".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 1 && optionsDisabled == 2:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".hide()
		$"Option 2".add_color_override("font_color", Color(0.35,0.35,0.35))
		$"Option 3".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 1 && optionsDisabled == 1:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".hide()
		$"Option 4".hide()
		$"Option 2".add_color_override("font_color", Color(0.35,0.35,0.35))
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 4:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		$"Option 4".text = option4Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".show()
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 3:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		$"Option 3".text = option3Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".show()
		$"Option 4".hide()
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 2:
		$"Option 1".text = option1Text
		$"Option 2".text = option2Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".show()
		$"Option 3".hide()
		$"Option 4".hide()
		funcisActive = true
		funcchoice = 1
		pass
	elif optionsActive == 1:
		$"Option 1".text = option1Text
		get_parent().show()
		$"Option 1".show()
		$"Option 2".hide()
		$"Option 3".hide()
		$"Option 4".hide()
		funcisActive = true
		funcchoice = 1
		pass
	else:
		print("Error, no elif statement for this option combo:")
		print(optionsActive)
		print(optionsDisabled)
	choice = funcchoice
	isActive = funcisActive

func _input(ev):
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
				choice = optionsActive
				currentChoice = get_node("Option " + str(choice) + "/Cursor")
				currentChoice.show()
		elif ev.scancode == KEY_RIGHT: # If right arrow is pressed
			if choice != optionsActive:
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
			print("You chose: " + str(choice))
			isActive = false 
			self.hide()
			$"Option 1".hide()
			$"Option 2".hide()
			$"Option 3".hide()
			$"Option 4".hide()
			$"Option 1".add_color_override("font_color", Color(1,1,1))
			$"Option 2".add_color_override("font_color", Color(1,1,1))
			$"Option 3".add_color_override("font_color", Color(1,1,1))
			$"Option 4".add_color_override("font_color", Color(1,1,1))
			emit_signal("player_choice", outputBranch, get_node("Option " + str(choice)).text)
			#send signal
		#print("Active: " + str(optionsActive) + "\nDisabled: " + str(optionsDisabled))
		#called everytime enter/left/right is pressed while isActive
