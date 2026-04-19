class_name Fractal
extends Control


signal interaction(is_pressed: bool)


func _on_button_button_down():
	interaction.emit(true)


func _on_button_button_up():
	interaction.emit(false)
