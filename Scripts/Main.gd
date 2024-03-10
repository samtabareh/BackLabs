extends Node

var is_dev = false

func print_as(Id : String, Message):
	print("[%s] " % Id, Message)

func exit():
	await SaveHandler.save_game()
	get_tree().quit()
