extends Control

@onready var Layer = $Layer

func _on_english_pressed():
	TranslationSwitcher.UpdateUI("en")

func _on_farsi_pressed():
	TranslationSwitcher.UpdateUI("fa")

func _on_exit_pressed():
	get_tree().quit()

func _input(event):
	if Input.is_action_just_pressed("Esc"):
		Layer.visible = !Layer.visible
		$CanvasLayer/Menu.visible = !Layer.visible


func _on_continue_pressed():
	Layer.visible = false
	$CanvasLayer/Menu.visible = true
	get_tree().paused = false

func _on_menu_pressed():
	Layer.visible = true
	$CanvasLayer/Menu.visible = false
	get_tree().paused = true

func _on_levels_pressed():
	get_tree().paused = false
	LevelHandler.change_level("res://Scenes/Main Menu/Levels.tscn")
