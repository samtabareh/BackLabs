@tool
class_name Text extends Node2D

## Emitted when text() is called. value is the array of strings
signal writing_started(value)
## Emitted when the text() is done writing.
signal writing_finished

@onready var label : Label = $MarginContainer/MarginContainer/Label
@onready var player : AnimationPlayer = $MarginContainer/MarginContainer/Label/Player

@export_range(1, 2, 0.5) var Size = 1.0

func _process(delta):
	$MarginContainer.scale = Vector2(Size/2, Size/2)

func text(a : String):
	writing_started.emit(a)
	label.name = a
	show()
	if a.length() < 10: player.play("Reveal1")
	else: player.play("Reveal2")
	await player.animation_finished
	writing_finished.emit()
