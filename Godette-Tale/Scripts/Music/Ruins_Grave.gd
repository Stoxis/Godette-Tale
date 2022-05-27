extends Node2D

onready var tie = get_node("/root/Root_Node/CanvasLayer/panel/text_interface_engine")
onready var dialogue = tie.get_parent()

func _init():
	globalVariables.cellList = []

func _ready():
	globalVariables.currentRoomDesc = "It's me"
	MusicController.play_music("res://Assets/Music/Empty.wav")
	globalVariables.tie = tie
	globalVariables.dialogue = dialogue
	print(tie)
