extends Node2D

@onready var levels = $CanvasLayer/Levels

func _ready():
	for category in LevelHandler.Levels.values():
		var sort = VBoxContainer.new()
		sort.name = category[1].Category
		levels.add_child(sort)
		for level : Level in category.values():
			var button : Button = $CanvasLayer/Exit/Exit.duplicate()
			
			# set its name
			button.name = level.Category+" "+level.Name.get_slice(".tscn", 0)
			# set its text in case its not being translated
			button.text = button.name
			# because its a dupe of exit its connected to the exit method and will exit when pressed...
			# so we disconnect it from that method.
			button.pressed.disconnect(_on_exit_pressed)
			# and connect it to the method we want.
			button.pressed.connect(level_pressed.bind(level))
			# add the button as the child of its category sort.
			sort.add_child(button)

func level_pressed(level : Level):
	LevelHandler.change_level(level)

func _on_exit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	LevelHandler.change_level("res://Scenes/Main Menu/Main.tscn")
