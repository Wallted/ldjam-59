class_name Fractal
extends Control


class Parameter:
	var shader_param: StringName
	var interval: Vector2
	var default: float
	
	func _init(sp: StringName, i: Vector2, d: float):
		shader_param = sp
		interval = i
		default = d


signal interaction(is_pressed: bool)

const FRAME_BUTTON_RELEASED = preload("uid://bbpahtqmppeyf")
const FRAME_BUTTON_PRESSED = preload("uid://dcn40m7ndrwwc")
const PLAYER_FRAME = preload("uid://y4db74t88hyh")
const PLAYER_FRAME_ACTIVE = preload("uid://bp2vwgmaj34ps")
const TARGET_FRAME = preload("uid://bpddt2mygitv1")
const TARGET_FRAME_ACTIVE = preload("uid://cd78hap87qmn3")
var shortcut: Shortcut

@export var is_player_fractal: bool


var parameters: Array[Parameter] = [
	
	Parameter.new("shader_parameter/color_phase", Vector2(0.5, 1.5), 1.0),
	Parameter.new("shader_parameter/color_freq", Vector2(2.5, 0.5), 1.0),
	
	Parameter.new("shader_parameter/c_x", Vector2(0.3, 0.5), 0.33),
	Parameter.new("shader_parameter/c_y", Vector2(0.4, 0.6), 0.48),
	
	Parameter.new("shader_parameter/center_x", Vector2(-0.2, 0.2), 0.0),
	Parameter.new("shader_parameter/center_y", Vector2(-0.2, 0.2), 0.0),
	
	Parameter.new("shader_parameter/hue_weight", Vector2(0.25, 0.75), 0.5),
	Parameter.new("shader_parameter/zoom", Vector2(0.4, -0.1), 0.0),
	
	Parameter.new("shader_parameter/rotation_angle", Vector2(0.0, PI), 0.5 * PI),
	Parameter.new("shader_parameter/fish_eye", Vector2(1.0, 0.0), 0.5),
]

var _level: Level
var _we_are_live: bool = false

@onready var frame: Sprite2D = $Frame
@onready var button: Button = $Button

func _ready() -> void:
	button.shortcut = shortcut
	if is_player_fractal:
		frame.texture = PLAYER_FRAME
	else:
		frame.texture = TARGET_FRAME

func _process(_delta):
	if _we_are_live and is_player_fractal:
		_refresh()
		
func _unhandled_input(event: InputEvent):
	if _level == null:
		return
	if is_player_fractal:
		if event.is_action_pressed("player_choir"):
			_set_button_pressed(true)
		if event.is_action_released("player_choir"):
			_set_button_pressed(false)
	else:
		if event.is_action_pressed("target_choir"):
			_set_button_pressed(true)
		if event.is_action_released("target_choir"):
			_set_button_pressed(false)


func start(level: Level):
	_level = level
	for param in parameters:
		material.set(param.shader_param, param.default)
	_refresh()
	_we_are_live = true


func stop():
	_we_are_live = false
	_level = null


func _refresh():
	for chorister in _level.player_choir if is_player_fractal else _level.target_choir:
		if chorister.species_id * 2 + 1 < parameters.size():
			var param_a := parameters[chorister.species_id * 2]
			var param_b := parameters[chorister.species_id * 2 + 1]
			var value_a := lerpf(param_a.interval.x, param_a.interval.y, inverse_lerp(0.0, chorister.EFFECT_MAX_GRID_SIZE, chorister.grid_position.x))
			var value_b := lerpf(param_b.interval.x, param_b.interval.y, inverse_lerp(0.0, chorister.EFFECT_MAX_GRID_SIZE, chorister.grid_position.y))
			material.set(param_a.shader_param, value_a)
			material.set(param_b.shader_param, value_b)


func _on_button_button_down():
	_set_button_pressed(true)


func _on_button_button_up():
	_set_button_pressed(false)


func _set_button_pressed(value: bool):
	interaction.emit(value)
	frame.texture = {
		true: {
			false: PLAYER_FRAME,
			true: PLAYER_FRAME_ACTIVE,
		},
		false: {
			false: TARGET_FRAME,
			true: TARGET_FRAME_ACTIVE,
		},
	}[is_player_fractal][value]
