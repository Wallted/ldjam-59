class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace

var level: Level

func load_new_level(level_data) -> void:
	level = Level.new(level_data)
	
	audio.level = level
	audio.who_sings = Audio.WhoSings.Target
	zoo_space.level = level
	
	zoo_space.restart()
