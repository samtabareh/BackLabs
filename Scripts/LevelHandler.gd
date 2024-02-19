extends Node

var Levels : Dictionary
var path = "res://Scenes/Levels/"

@onready var current_level : Level :
	get:
		var temp = get_tree().current_scene.scene_file_path
		for cat in Levels.keys():
			var ids = Levels[cat]
			for id in ids:
				var level : Level = Levels[cat][id]
				if level.Path == temp:
					current_level = level
					return current_level
		return

func init_levels():
	var dir = DirAccess.open(path)
	Levels = {}
	load_dir(dir)

func next_level() -> Level:
	var next = Levels[current_level.Category].get(current_level.Id+1)
	if next == null: push_error("No other level exists")
	return next

func change_level(level):
	if !level is Level && !level is String:
		push_error("Invalid level given, expected a Level res or path String.")
	if level is Level: get_tree().change_scene_to_file(level.Path)
	elif level is String: get_tree().change_scene_to_file(level)

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
				print("Found file: "+file_name)
				
				var num = file_name.get_slice("_",1)
				num = num.get_slice(".",0)
				
				if file_name.split(".", 1)[1] == "tscn":
					print("Adding file: ", path,folder_name,'/', file_name," to ", folder_name)
					
					if Levels.get(folder_name) == null:
						Levels[folder_name] = {}
					var level = Level.new().Level(int(num),file_name,folder_name,path+folder_name+"/"+file_name)
					Levels[folder_name][level.Id] = level
			else:
				print("Found directory: " + file_name)
				Levels[folder_name] = {}
				
				var new_dir = DirAccess.open(dir.get_current_dir()+"/"+file_name)
				load_dir(new_dir)
			
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path. Error: ",
		DirAccess.get_open_error())
	Levels.erase("Levels")
