extends Node

@onready var game: Game = $Game

func _ready() -> void:
	game.load_new_level()
