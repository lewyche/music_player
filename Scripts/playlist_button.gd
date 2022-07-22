extends Button

onready var playlist_songs = get_node("../../../../Playlist_songs")
onready var scroll_container = get_node("../../")
var editing = false

func _ready():
	pass # Replace with function body.

func _input(event):
	#force user to give playlist a name
	if editing == true:
		if event.is_action_pressed("enter"):
			rename()

func rename():
	text = get_parent().get_parent().check_duplicate_names($TextEdit.text)
	$TextEdit.visible = false
	editing = false

func get_playlist():
	return scroll_container.get_playlist(text)
	
func _on_playlist_button_pressed():
	playlist_songs.visible = true
	playlist_songs.set_current_playlist(get_playlist())
	playlist_songs.display_playlist() 
	get_node("../../../../../Music Controls/next_song_nexus").get_playlist(get_playlist())

func _on_TextEdit_text_changed():
	editing = true
