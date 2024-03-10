extends Main

var path = "res://Resources/"
var id = "TypesLoader"

func _ready():
	TypesLoader.init_dicts()

func init_dicts():
	var dir = DirAccess.open(path)
	load_dir(dir)

func load_dir(dir : DirAccess):
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		
		while file_name != "":
			var folder_name = dir.get_current_dir().split("/")
			folder_name = folder_name[folder_name.size()-1]
			
			if not dir.current_is_dir():
				Main.print_as(id, "Found file: "+ file_name)
			
				if file_name.ends_with(".tres"):
					var file_path = path+folder_name+"/"+file_name
					var res = load(file_path)
					
					if res is AtomT:
						Atoms[res.Name] = res
						print_as(id, "Adding file: "+ file_path+ " to Atoms")
						
					if res is MoleculeT:
						Molecules[res.Name] = res
						print_as(id, "Adding file: "+ file_path+ " to Molecules")
			else:
				print_as(id, "Found directory: " + file_name)
				var new_dir = DirAccess.open(dir.get_current_dir()+"/"+file_name)
				load_dir(new_dir)
			
			file_name = dir.get_next()

var Atoms : Dictionary = {}
var Molecules : Dictionary = {}
