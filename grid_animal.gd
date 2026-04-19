extends Node2D

@export var zoo_space: ZooSpace
@onready var texture_button = $TextureButton

const const_lerp_catch_factor_velocity = 1.5

var _is_pressing = false
var _lerp_factor = 0.0
var _previous_point: Vector2
var species_id: int

signal position_changed(new_position: Vector2)

func _ready() -> void:
	var res = Species.ChoristerResMap[species_id]
	texture_button.texture_normal = res
	
func _process(delta: float) -> void:
	handle_mouse_drag(delta)

func handle_mouse_drag(delta: float):
	if _is_pressing:
		var global_coords = get_global_mouse_position()
		_lerp_factor += clamp(const_lerp_catch_factor_velocity * delta, 0, 1)
		global_position = lerp(global_position, global_coords, ease(_lerp_factor, -4.0))
		zoo_space.grid_process_cell(global_position) # debug

	var is_in_bounds = zoo_space.grid_is_in_bounds(global_position)

	if not _is_pressing:
		if not is_in_bounds and _previous_point:
			global_position = lerp(global_position, _previous_point, 0.1)

	if is_in_bounds:
		_previous_point = global_position
		var local_position_normalized = zoo_space.grid_get_local_position_normalized(global_position)
		position_changed.emit(local_position_normalized)
		update_label('%s' % local_position_normalized)
	else:
		update_label('OOO')

func _on_texture_button_button_up() -> void:
	_is_pressing = false
	_lerp_factor = 0.0

func _on_texture_button_button_down() -> void:
	_is_pressing = true

# trash
@onready var label = $Label
func update_label(text):
	label.text = text
