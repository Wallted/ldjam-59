class_name Fractal
extends Control


signal interaction(is_pressed: bool)

const FRAME_BUTTON_RELEASED = preload("uid://bbpahtqmppeyf")
const FRAME_BUTTON_PRESSED = preload("uid://dcn40m7ndrwwc")


@onready var frame: Sprite2D = $Frame


func _on_button_button_down():
	interaction.emit(true)
	frame.texture = FRAME_BUTTON_PRESSED


func _on_button_button_up():
	interaction.emit(false)
	frame.texture = FRAME_BUTTON_RELEASED
