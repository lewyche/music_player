extends Container

onready var music_button = preload("res://Scenes/playlist_music_button.tscn")
onready var music_files = get_node("../../File Path/ScrollContainer/Files")
onready var music_player = get_node("../../../music_player")
onready var Playlists = get_node("../Playlists")
var current_song = ""

var current_playlist = []

func set_current_playlist(playlist):
	current_playlist = playlist

func reset_playlist():
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()

func display_playlist():
	reset_playlist()
	for i in range(current_playlist.songs.size()):
		var new_button = music_button.instance()
		$ScrollContainer.get_node("VBoxContainer").add_child(new_button)
		new_button.set_text(current_playlist.songs[i])

#start the selection of songs to add to playlist
func start_playlist_selection():
	music_files.set_playlist_selection_mode()

func end_playlist_selection():
	music_files.set_music_selection_mode()

func add_to_playlist(name):
	current_playlist.songs.append(name)
	display_playlist()
	get_node("../../Music Controls/next_song_nexus").get_playlist(current_playlist)	
func delete_from_playlist():
	if current_song != "":
		current_playlist.songs.erase(current_song)
		get_node("../../Music Controls/next_song_nexus").get_playlist(current_playlist)	
	else:
		print("No current song!!!!")

#get current song
func ready_delete(curr_song):
	current_song = curr_song
	$Delete_song.visible = true

func _ready():
	pass


func _on_ExitPlaylistSelection_pressed():
	end_playlist_selection()
	$ExitPlaylistSelection.visible = false
	$StartPlaylistSelection.visible = true

func _on_StartPlaylistSelection_pressed():
	start_playlist_selection()
	$Delete_song.visible = false
	$StartPlaylistSelection.visible = false
	$ExitPlaylistSelection.visible = true

func _on_Delete_song_pressed():
	music_player.pause_music()
	delete_from_playlist()
	display_playlist()
	$Delete_song.visible = false

func _on_Delete_playlist_pressed():
	reset_playlist()
	Playlists.get_node("ScrollContainer").delete_playlist(current_playlist)
	display_playlist()
	Playlists.saved_playlists.erase(current_playlist)
