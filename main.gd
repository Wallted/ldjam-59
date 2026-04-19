extends Node

@onready var game: Game = $Game

func _ready() -> void:
	var level_idx = 1
	game.load_new_level(get_level_data(level_idx))

func get_level_data(level_idx):
	var level_data = LevelData.new()
	level_data.unmarhshal(level_idx)
	return level_data
