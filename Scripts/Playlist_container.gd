extends Container

var write_file = File.new()
var read_file = File.new()

var saved_playlists = []

func save(content):
	write_file.store_line(content)

func read():
	if read_file.get_len() > 0:
		while !read_file.eof_reached():
				var dict = parse_json(read_file.get_line())
				if dict is Dictionary:
					$ScrollContainer.add_existing_playlist(dict)

		
func _ready():

	var path = "res://Data/user_data.json"

	var read_write = File.new()
	
	if read_file.file_exists("res://Data/user_data.json"):
		if read_file.open(path, File.READ) == 0:
			read()

		else:
			print("no file found")
		
	
	if write_file.open(path, File.WRITE) == 0:
		pass
	else:
		print("FILE OPEN FAILED")
		
	save_playlist()
	

func check_for_duplicates(playlist):
	for i in saved_playlists:
		if i.name == playlist.name:
			return true
	return false
		
		
func save_playlist():
	for i in $ScrollContainer.playlists:
		if !check_for_duplicates(i):
			print(i.name)
			print(i.songs)
			save(to_json(i))
			saved_playlists.append(i)
		
func _on_new_playlist_pressed():
	$ScrollContainer.add_new_playlist_button()

func _on_save_playlist_pressed():
	save_playlist()
