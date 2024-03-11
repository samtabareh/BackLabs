extends Node

var is_dev = false

func print_as(Message):
	# stack structure -> [{function:foo, line:1, source:res://temp/self.gd}, ...]
	var id : String = get_stack()[1]["source"]
	id = id.get_file().get_slice(".", 0)
	
	var color = ("green" if id == "SaveHandler" else 
	"orange" if id == "TranslationSwitcher" else
	"purple" if id == "LevelHandler" else
	"gray")
	
	print_rich("[color=%s][%s][/color] %s" % [color, id, Message])

func exit():
	await SaveHandler.save_game()
	get_tree().quit()
