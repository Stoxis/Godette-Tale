extends Node

func play_music(s): #Input is a file location: play_music("res://Assets/Music/Ruins.wav")
	if $Music.stream.resource_path != s:
		$Music.stream = load(s)
		$Music.play()

func pause_music(s): #true to pause, false to play
	$Music.set_stream_paused(s)

func stop_music():
	$Music.stream = load("res://Assets/Music/Empty.wav")
	$Music.play()
