class_name Level extends Resource

@export var Id : int
@export var Name : String
@export var Category : String
@export var Path : String

func Level(id: int, name: String, category: String, path: String):
	Id = id
	Name = name
	Category = category
	Path = path
	return self
