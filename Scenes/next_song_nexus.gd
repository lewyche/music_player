extends Node

var playing_from_files = true

var files = []
var playlist = []

func play_next_song():
	print("balls")
	print(playing_from_files)
	
func play_from_files():
	playing_from_files = true

func play_from_playlist():
	playing_from_files = false
	
func get_files(f):
	files = f

func get_playlist(l):
	pass

func _ready():
	pass # Replace with function body.
