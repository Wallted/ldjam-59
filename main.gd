extends Node

@onready var game: Game = $Game

func _ready() -> void:
	game.load_new_level(get_level_data(0))

func get_level_data(_idx): 
	var level_data = { # mock
		"x": 30,
		"y": 20,
		"player_data": [
			# species, freq
			[0, 400.0],
			[0, 600.0],
		], 
		"target_data": [
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
			[0, 200.0],
		],
	}
	return level_data
