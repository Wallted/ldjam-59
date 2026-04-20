class_name GridAnimal
extends Node2D

@export var zoo_space: ZooSpace
@onready var texture_button = $TextureButton
@onready var animated_sprite = $TextureButton/AnimatedSprite2D
@onready var animated_sprite_2 = $TextureButton/AnimatedSprite2D2

const const_lerp_catch_factor_velocity = 4.5
const _chungus_scale = 0.35

var _is_pressing = false
var _lerp_factor = 0.0
var _previous_point: Vector2
var species_id: int
var chorister_idx: int

signal position_changed(new_position: Vector2)
signal animal_dropped()
signal animal_dragged(chorister_idx)

func _ready() -> void:
	var res_list = Species.ChoristerResMapPreload[species_id]
	
	animated_sprite.sprite_frames.add_frame('idle', res_list[0])
	animated_sprite.sprite_frames.add_frame('idle', res_list[1])
	animated_sprite.sprite_frames.add_frame('sing', res_list[2])
	animated_sprite.sprite_frames.add_frame('sing', res_list[3])

	animated_sprite_2.sprite_frames = animated_sprite.sprite_frames
	animated_sprite_2.scale *= 1.05

	texture_button.scale = Vector2(_chungus_scale, _chungus_scale)
	texture_button.position = -texture_button.size / 2.0

	var base_res = res_list[0]
	#texture_button.texture_normal = base_res
	var bitmap: BitMap = BitMap.new()
	bitmap.create_from_image_alpha(base_res.get_image())
	texture_button.texture_click_mask = bitmap
	#shade.texture = bitmap

	if not _previous_point:
		_previous_point = global_position

	change_animation('idle')

func _process(delta: float) -> void:
	handle_mouse_drag(delta)

func handle_mouse_drag(delta: float):
	if _is_pressing:
		var global_coords = get_global_mouse_position()
		_lerp_factor += clamp(const_lerp_catch_factor_velocity * delta, 0, 1)
		global_position = lerp(global_position, global_coords, ease(_lerp_factor, -4.0))
		animal_dragged.emit(chorister_idx)

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

	if _is_pressing and is_in_bounds:
		zoo_space.grid_process_cell(global_position)

func change_animation(_name: String):
	animated_sprite.play(_name)
	animated_sprite_2.play(_name)

	 # this has nothing to do with animation, but is called everywhere needed from there
	zoo_space.grid_process_cell(Vector2.INF)
	
func _on_texture_button_button_up() -> void:
	change_animation('idle')
	_is_pressing = false
	_lerp_factor = 0.0
	animal_dropped.emit()

func _on_texture_button_button_down() -> void:
	change_animation('sing')
	_is_pressing = true

# trash
@onready var label = $Label
func update_label(text):
	label.text = text
