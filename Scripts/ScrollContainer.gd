extends ScrollContainer

#related scenes:
#playlist_music_button, playlist_button, Playlist, Main interface

var playlist_button = preload("res://Scenes/playlist_button.tscn")
onready var music_player = get_node("../../../../music_player")

var playlists = []
var playlists_buttons = []

func check_duplicate_names(name):
	for i in range(playlists.size()):
		if playlists[i].name == name:
			name = name + " 1"
	add_playlist(name)
	return name

func get_playlist(name):
	for i in range(playlists.size()):
		if playlists[i].name == name:
			return playlists[i]
	print("BIG ERROR")

func add_new_playlist_button():
	var new_button = playlist_button.instance()
	$VBoxContainer.add_child(new_button)

func add_existing_playlist_button(name):
	var new_button = playlist_button.instance()
	$VBoxContainer.add_child(new_button)
	new_button.get_node("TextEdit").visible = false
	new_button.text = name

func add_playlist(name):
	print("added")
	var new_dict = {
		"name" : name,
		"songs" : []
	}
	playlists.append(new_dict)

func add_existing_playlist(playlist):
	playlists.append(playlist)
	add_existing_playlist_button(playlist.name)

func delete_playlist_button(name):
	for i in $VBoxContainer.get_children():
		if i.text == name:
			i.queue_free()

func delete_playlist(name):
	playlists.erase(name)
	delete_playlist_button(name.name)

func play_next_song():
	pass

func _ready():
	pass
