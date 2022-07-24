extends Node

onready var music_player = get_node("../../../music_player")

var playing_from_files = true

var files = []
var playlist = []

func play_next_song():
	var current_song = get_parent().get_node("current_song")
	if current_song.text != "":
		if playing_from_files == true:
			var index = files.find(current_song.text)
			if index < files.size() - 1:
				music_player.set_music_stream("res://Music/" + files[index + 1])
				get_parent().get_node("current_song").text = files[index + 1]
		else:
			var index = playlist.songs.find(current_song.text)
			if index < playlist.songs.size() - 1:
				music_player.set_music_stream("res://Music/" + playlist.songs[index + 1])
				get_parent().get_node("current_song").text = playlist.songs[index + 1]
	
func play_from_files():
	playing_from_files = true

func play_from_playlist():
	playing_from_files = false
	
func get_files(f):
	files = f

func get_playlist(l):
	playlist = l

func _ready():
	pass # Replace with function body.
