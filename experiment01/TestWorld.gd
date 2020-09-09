extends Node2D

onready var MessageBox = $CanvasLayer/Control/NinePatchRect/ColorRect/Message


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("master")
	play_message("Hello! Welcome to my story!")


func play_message(message):
	print("Will display: %s" % message)
	MessageBox.text = message
