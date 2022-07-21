extends Container

var write_file = File.new()
var read_file = File.new()

func save(content):
	write_file.store_line(content)

func read():
	while !read_file.eof_reached():
		print("reading??")
		var dict = parse_json(read_file.get_line())
		if dict is Dictionary:
			$ScrollContainer.add_existing_playlist(dict)

		
func _ready():

	var path = "res://Data/user_data.json"
	
	#check if file exists before opening because opening creates the file lmao
	if read_file.open(path, File.READ) == 0:
		read()
	else:
		print("no file found")
	
	if write_file.open(path, File.WRITE) == 0:
		print("success")
	else:
		print("FILE OPEN FAILED")
			

		
func _on_new_playlist_pressed():
	$ScrollContainer.add_new_playlist_button()

func _on_save_playlist_pressed():
	for i in $ScrollContainer.playlists:
		print(i.name)
		print(i.songs)
		save(to_json(i))
