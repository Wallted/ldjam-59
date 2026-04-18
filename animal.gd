class_name Animal
extends Node2D

@onready var button = $TextureButton
@onready var label = $Label
@export var zoo_space: ZooSpace

const const_lerp_catch_factor_velocity = 1.5

var pressing = false
var lerp_factor = 0.0
var previous_point: Vector2

func _process(delta: float) -> void:
	if pressing:
		var global_coords = get_global_mouse_position()
		lerp_factor += clamp(const_lerp_catch_factor_velocity * delta, 0, 1)
		global_position = lerp(global_position, global_coords, ease(lerp_factor, -4.0))
	else:
		lerp_factor = 0.0

	if pressing:
		zoo_space.grid_process_cell(global_position)
	else:
		if not zoo_space.grid_is_in_bounds(global_position) and previous_point:
			global_position = lerp(global_position, previous_point, 0.1)
		else:
			previous_point = global_position
			#print('previous point %s' % previous_point)
	
	if zoo_space.grid_is_in_bounds(global_position):
		previous_point = global_position
		var local_position_normalized = zoo_space.grid_get_local_position_normalized(global_position)
		update_label('%s' % local_position_normalized)
	else:
		update_label('OOO')
	
func _on_texture_button_button_up() -> void:
	pressing = false

func _on_texture_button_button_down() -> void:
	pressing = true

func update_label(text):
	label.text = text
