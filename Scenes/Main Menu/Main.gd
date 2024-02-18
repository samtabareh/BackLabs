extends Node2D

func _ready():
	LevelHandler.init_levels()

func _on_start_pressed():
	LevelHandler.change_level(LevelHandler.Levels["Main"][1])

func _on_tutorial_pressed():
	LevelHandler.change_level(LevelHandler.Levels["Tutorial"][1])

func _on_exit_pressed():
	get_tree().quit()

func _on_en_pressed():
	TranslationSwitcher.UpdateUI("en")

func _on_fa_pressed():
	TranslationSwitcher.UpdateUI("fa")
