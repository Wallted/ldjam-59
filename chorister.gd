class_name Chorister
extends RefCounted


var _freq: float
var _phase := 0.0
var _increment := 0.0

var grid_animal: GridAnimal


func _init(freq: float) -> void:
	change_freq(freq)


func synthesize():
	var frame = _specific_math()
	_phase = fmod(_phase + _increment, 1.0)
	return frame


func change_freq(new_freq: float):
	_freq = new_freq
	_increment = _freq / Audio.config_sample_hz


func _specific_math():
	return 0.0
