extends Node2D

@onready var display: DisplayText = $DisplayText

func _ready():
	await display.text(["Main_1-1", "Main_1-2", "Main_1-3"])
