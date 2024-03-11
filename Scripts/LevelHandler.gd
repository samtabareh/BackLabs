extends Main

## { "Category": { 1: Level, 2: Level2 }, "Category2": { 1: Level } }
var Levels := {}
## Contains the path for levels not the levels
var UnlockedLevels : Array[Level] = []

var path = "res://Scenes/Levels/"

@onready var current_level : Level :
	get:
		var temp = get_tree().current_scene.scene_file_path
		for category in Levels.values(): for level : Level in category.values():
				if level.Path == temp:
					current_level = level
					return current_level
		return

func _ready():
	LevelHandler.init_levels()

func init_levels():
	Levels = {}
	var dir = DirAccess.open(path)
	load_dir(dir)

func next_level() -> Level:
	var next = Levels[current_level.Category].get(current_level.Id+1)
	if next == null: push_error("No other level exists")
	return next

func get_level_from_path(path : String):
	if Levels.is_empty(): return
	for category in Levels.values():
		for level : Level in category.values():
			if path == level.Path: return level

func change_level(level):
	if !level is Level && !level is String:
		push_error("Invalid level given, expected a Level res or path String.")
	
	if level is String: get_tree().change_scene_to_file(level)
	if level is Level:
		if !UnlockedLevels.has(level): UnlockedLevels.append(level)
		get_tree().change_scene_to_file(level.Path)

func load_dir(dir : DirAccess):
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var folder_name = dir.get_current_dir().split("/")
			folder_name = folder_name[folder_name.size()-1]
			
			if file_name.ends_with(".remap"):
				file_name = file_name.trim_suffix(".remap")
			
			if not dir.current_is_dir():
				print_as("Found file: "+file_name)
				
				var num = file_name.get_slice("_",1)
				num = num.get_slice(".",0)
				
				var file_path = path+folder_name+'/'+file_name
				
				if file_name.split(".", 1)[1] == "tscn":
					print_as("Adding file: "+ file_path+ " to "+ folder_name)
					
					if Levels.get(folder_name) == null:
						Levels[folder_name] = {}
					var level = Level.new().Level(int(num),file_name,folder_name,file_path)
					Levels[folder_name][level.Id] = level
			else:
				print_as("Found directory: "+ file_name)
				Levels[folder_name] = {}
				
				var new_dir = DirAccess.open(dir.get_current_dir()+"/"+file_name)
				load_dir(new_dir)
			
			file_name = dir.get_next()
	else:
		print_as("An error occurred when trying to access the path. Error: "+
		str(DirAccess.get_open_error()))
	Levels.erase("Levels")
