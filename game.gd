class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace

var level: Level

func _ready() -> void:
	audio.who_sings = Audio.WhoSings.Target
	load_new_level()

func load_new_level() -> void:
	level = Level.new()
	
	audio.level = level
	zoo_space.level = level
	
	zoo_space.restart()
