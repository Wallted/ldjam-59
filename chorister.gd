class_name Chorister
extends RefCounted


const EFFECT_MAX_GRID_SIZE := 13


var grid_size: Vector2
var _freq: float
var _phase := 0.0
var _increment := 0.0

var species_id: int
var grid_position: Vector2



func _init(_species_id: int, x: float, y: float) -> void:
	species_id = _species_id
	grid_position = Vector2(x, y)

func synthesize():
	var frame = _specific_math()
	_phase = fmod(_phase + _increment, 1.0)
	return frame


func change_freq(new_freq: float):
	_freq = new_freq
	_increment = _freq / Audio.config_sample_hz


func _specific_math():
	return 0.0

func _on_grid_position_changed(new_position: Vector2):
	grid_position = new_position
