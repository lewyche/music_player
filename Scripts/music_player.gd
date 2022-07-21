extends AudioStreamPlayer

var looping = false
var new_music
var playback_pos = 0.0
var progress = 0
var music_loaded = false

func pause_music():
	if playing == true:
		stop()

func start_music():
	if playing == false:
		play(playback_pos)

func set_music_stream(path):
	new_music = load(path)
	music_loaded = true
	
	stream = new_music
	
	#reset playback pos
	playback_pos = 0.0
	new_music.loop = false
	start_music()

func toogle_music():
	#if music is playing pause
	if playing == true:
		pause_music()
		return playing
	else:
	#otherwise restart music
		start_music()
		return playing

func toogle_looping():
	if new_music.loop == false:
		new_music.loop = true
		return new_music.loop
		
	elif new_music.loop == true:
		new_music.loop = false
		return new_music.loop

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func convert_to_percentage(playback):
	return round((playback / new_music.get_length() ) * 100)

func convert_to_playback_pos(percentage):
	if music_loaded == false:
		return 0
	return (percentage / 100) * new_music.get_length()

func percentage_to_db(percentage):
	#garbage formula fix later
	return percentage / 5 - 20

func change_playback_pos(percentage):
	playback_pos = convert_to_playback_pos(percentage)

func change_volume(percentage):
	volume_db = percentage_to_db(percentage)

func _process(delta):
	if playing == true:
		playback_pos = get_playback_position()
		progress = convert_to_percentage(playback_pos)
		
