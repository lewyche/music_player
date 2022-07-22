extends VBoxContainer

onready var button = preload("res://Scenes/music_button.tscn")
onready var music_button = get_node("../../../../music_player")

var buttons = []

var playlist_selection_mode = false

func add_files(files, dir):
	while true:
		var file = dir.get_next()
		if file == "":
			break
		#check if file is not a directory
		elif not file.begins_with("."):
			#check if file is an music file
			if file.ends_with(".mp3"):
				files.append(file)
	return files

func get_files(path):
	var files = []
	var dir = Directory.new()
	#check if directory can be opened
	if dir.open(path) == 0:
		#initalize list directory stream
		if dir.list_dir_begin() != 0:
			print("LIST DIR BEGIN FAILED")
			return ["FAILED"]
		else:
			#add files to array
			files = add_files(files, dir)
			dir.list_dir_end()
			return files
	else:
		print("DIRECTORY OPEN FAILED")
		return ["FAILED"]

func put_files_to_screen(files):
	for i in range(len(files)):
		var new_button = button.instance()
		add_child(new_button)
		new_button.set_text(files[i])
		
		buttons.append(new_button)

func set_playlist_selection_mode():
	playlist_selection_mode = true
	for i in range(buttons.size()):
		buttons[i].playlist_selection_mode = true
		
func set_music_selection_mode():
	playlist_selection_mode = false
	for i in range(buttons.size()):
		buttons[i].playlist_selection_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var files = get_files("res://Music/")
	if files[0] != "FAILED":
		put_files_to_screen(files)
		get_node("../../../Music Controls/next_song_nexus").get_files(files)
