class_name DisplayText extends CanvasLayer

##
signal box_clicked
## Emitted when text() is called. value is the array of strings
signal writing_started(value)
## 
signal writing_changed(value)
## Emitted when the text() is done writing.
signal writing_finished

@onready var label : Label = $MarginContainer/MarginContainer/Label
@onready var player : AnimationPlayer = $MarginContainer/MarginContainer/Label/Player

func text(a : Array):
	writing_started.emit(a)
	for s in a:
		if !s is String: continue
		label.name = s
		show()
		player.play("RESET")
		player.play("Reveal", 1, clamp(s.length()/5, .5, 1.5))
		#if s.length() < 24: player.play("Reveal2")
		#else: player.play("Reveal3")
		await player.animation_finished
		await box_clicked
	hide()
	writing_finished.emit()

func _on_input(event):
	if Input.is_action_just_pressed("click"):
		box_clicked.emit()
