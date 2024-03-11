extends Main

var SaveDir = "user://"
var SaveName = "save.BackLabs"
var SavePath = SaveDir + SaveName

func _ready():
	SaveHandler.load_game()

func _input(event):
	if Input.is_action_just_released("dev-del") && Main.is_dev:
		DirAccess.remove_absolute(SavePath)
		LevelHandler.UnlockedLevels = []
		print_as("Deleted save")

func save_game():
	var save_dict = {
		"Unlocked_Levels": []
	}
	for level in LevelHandler.UnlockedLevels:
		save_dict["Unlocked_Levels"].append(level.Path)
	
	var save = FileAccess.open(SavePath, FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save.store_var(json_string)
	print_as("Saved game file to: "+OS.get_user_data_dir()+"/save.BackLabs")

func load_game():
	if not FileAccess.file_exists(SavePath):
		print_as("Save file doesnt exist!")
		return
	
	var save = FileAccess.open(SavePath, FileAccess.READ)
	while save.get_position() < save.get_length():
		var json_string = save.get_var()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print_as("JSON Parse Error: "+ json.get_error_message()+ " in "+ json_string+ " at line "+ json.get_error_line())
			continue
		
		var data = json.get_data()
		
		# If the string is for ULs (Unlocked Levels)
		for i in data.keys(): 
			if i == "Unlocked_Levels": for path in data[i]:
				var level : Level = LevelHandler.get_level_from_path(path)
				# The levels path matches the saved path AND the level isnt already in the array
				if !LevelHandler.UnlockedLevels.has(level):
					# Add the level to the array
					LevelHandler.UnlockedLevels.append(level)
	
	print_as("Loaded save successfuly!")
