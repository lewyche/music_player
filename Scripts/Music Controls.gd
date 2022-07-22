extends Container

onready var music_player = get_parent().get_parent().get_node("music_player")

var playing = true
var looping = false

#is mouse inside ProgressBar control
var mouse_in = false
#is progressbar waiting for userinput
var waiting = false

func change_current_song(song):
	$current_song.text = song

func _ready():
	#match volumecontrol volume with music player volum 
	music_player.change_volume($VolumeControl.value)

func change_play_button():
	#if not playing
	if playing == false:
		#show play button
		$play_button.icon = load("res://Assets/play_button.png")
	else:
		#show pause button
		$play_button.icon = load("res://Assets/pause_button.png")


func change_loop_button():
	#TODO: change into a toogle button
	if looping == true:
		#if looping, darken button
		$loop_button.modulate = Color(.5,.5,.5)
	else:
		$loop_button.modulate = Color(1,1,1)

func _on_play_button_pressed():
	playing = music_player.toogle_music()
	change_play_button()

func _on_loop_button_pressed():
	looping = music_player.toogle_looping()
	change_loop_button()

func _process(delta):
	if waiting == true:
		if mouse_in == false:
			#TODO: maybe change it so that it restarts when you release the mouse?
			#once mouse leaves the control area, restart the music
			music_player.change_playback_pos($ProgressBar.value)
			music_player.start_music()
			waiting = false
	elif $ProgressBar.value != music_player.progress:
		#set progressBar to the progress of the song
		$ProgressBar.value = music_player.progress

func _input(event):
	if event.is_action_pressed("click"):
		#when user clicks on progress bar, stop the song
		if mouse_in == true:
			waiting = true
			music_player.pause_music()

func _on_ProgressBar_mouse_entered():
	mouse_in = true

func _on_ProgressBar_mouse_exited():
	mouse_in = false
 
func _on_VolumeControl_value_changed(value):
	music_player.change_volume(value)

func _on_ProgressBar_value_changed(value):
	if value >= 100:
		$next_song_nexus.play_next_song()
