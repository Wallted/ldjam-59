extends Control


@onready var audio: Audio = $Audio


func _ready() -> void:
	# mock
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.who_sings = Audio.WhoSings.Target
