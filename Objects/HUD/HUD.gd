extends Control

@onready var Layer = $Layer

func _ready():
	$Layer/Level/Level.text = LevelHandler.current_level.Name

func _on_english_pressed():
	TranslationSwitcher.UpdateUI("en")

func _on_farsi_pressed():
	TranslationSwitcher.UpdateUI("fa")

func _on_exit_pressed():
	Main.exit()

func _input(event):
	if Input.is_action_just_released("Esc"):
		Layer.visible = !Layer.visible
		$CanvasLayer/Menu.visible = !Layer.visible
	
	if Input.is_action_just_released("dev-toggle") && Main.is_dev:
		$Layer/Level.visible = !$Layer/Level.visible

func _on_continue_pressed():
	Layer.visible = false
	$CanvasLayer/Menu.visible = true
	get_tree().paused = false

func _on_menu_pressed():
	Layer.visible = true
	$CanvasLayer/Menu.visible = false
	get_tree().paused = true

func _on_save_pressed():
	SaveHandler.save_game()

func _on_levels_pressed():
	get_tree().paused = false
	LevelHandler.change_level("res://Scenes/Main Menu/Levels.tscn")
