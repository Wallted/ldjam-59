extends Control


@onready var audio: Audio = $Audio


func _ready() -> void:
	# mock
	audio.target_choir.append(Sinoceros.new(440.0))
	audio.target_choir.append(Sinoceros.new(640.0))
	audio.target_choir.append(Sinoceros.new(840.0))
	audio.play_target_choir = true
