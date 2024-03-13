extends Node2D

@onready var display : DisplayText = $DisplayText

func _ready():
	await display.text(["Main_3-1", "Main_3-2"])
