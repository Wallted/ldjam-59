class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace

var level: Level

func load_new_level(level_data: LevelData) -> void:
	level = Level.new(level_data)

func _ready() -> void:
	# mock
	audio.target_choir.append(Sinoceros.new(200.0))
	audio.target_choir.append(Sinoceros.new(110.0))
	audio.target_choir.append(qudratoppator.new(220.0))
	audio.target_choir.append(Sinoceros.new(90.0))
	
	audio.who_sings = Audio.WhoSings.Target
