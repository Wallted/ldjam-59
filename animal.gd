class_name Animal
extends Node2D

@onready var button = $TextureButton

@export var zoo_space: ZooSpace

const const_lerp_catch_factor_velocity = 1

var pressing = false
var lerp_factor = 0.0

func _process(delta: float) -> void:
	print(pressing)
	if pressing:
		var global_coords = get_global_mouse_position()
		lerp_factor += clamp(const_lerp_catch_factor_velocity * delta, 0, 1)
		global_position = lerp(global_position, global_coords, ease(lerp_factor, -4.0))
	else:
		lerp_factor = 0.0
	
func _on_texture_button_button_up() -> void:
	pressing = false

func _on_texture_button_button_down() -> void:
	pressing = true
