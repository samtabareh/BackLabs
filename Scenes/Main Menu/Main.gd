extends Node2D

func _ready():
	if LevelHandler.UnlockedLevels.is_empty(): $CanvasLayer/Game/Start.visible = false
	for level in LevelHandler.UnlockedLevels:
		if level.Category != "Tutorial":
			$CanvasLayer/Game/Start.visible = true
			break
		$CanvasLayer/Game/Start.visible = false

func _on_start_pressed():
	LevelHandler.change_level(LevelHandler.Levels["Main"][1])

func _on_exit_pressed():
	Main.exit()

func _on_tutorial_pressed():
	LevelHandler.change_level(LevelHandler.Levels["Tutorial"][1])

func _on_levels_pressed():
	LevelHandler.change_level("res://Scenes/Main Menu/Levels.tscn")

func _on_save_pressed():
	SaveHandler.save_game()

func _on_load_pressed():
	SaveHandler.load_game()

func _on_en_pressed():
	TranslationSwitcher.UpdateUI("en")

func _on_fa_pressed():
	TranslationSwitcher.UpdateUI("fa")

