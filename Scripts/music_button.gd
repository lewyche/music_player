extends Button

onready var music_controls = get_node("../../../../Music Controls")
onready var music_player = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("music_player")
onready var playlist_songs = get_node("../../../../Playlist/Playlist_songs")

var playlist_selection_mode = false

func set_text(txt):
	text = txt

func set_current_song():
	music_controls.change_current_song(text)
	
func start_playing():
	music_player.set_music_stream("res://Music/" + text)

func _ready():
	clip_text = false

func _on_music_button_pressed():
	if playlist_selection_mode == false:
		set_current_song()
		start_playing()
	else:
		playlist_songs.add_to_playlist(text)

