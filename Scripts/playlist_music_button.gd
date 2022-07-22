extends Button

onready var music_controls = get_node("../../../../../Music Controls")
onready var music_player = get_node("../../../../../../music_player")
onready var playlist_songs = get_node("../../../../Playlist_songs")
onready var next_song_nexus = music_controls.get_node("next_song_nexus")

func set_text(txt):
	text = txt

func set_current_song():
	music_controls.change_current_song(text)
	
func start_playing():
	music_player.set_music_stream("res://Music/" + text)

func _ready():
	clip_text = false

func _on_playlist_music_button_pressed():
	set_current_song()
	start_playing()
	playlist_songs.ready_delete(text)
	next_song_nexus.play_from_playlist()
