extends Node2D

func _ready():
	globalVariables.currentRoomDesc = "It's me"
	MusicController.play_music("res://Assets/Music/Empty.wav")
