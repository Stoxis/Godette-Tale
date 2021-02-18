extends Node2D

func _ready():
	globalVariables.currentRoomDesc = "The void"
	MusicController.play_music("res://Assets/Music/Amalgam.wav")
