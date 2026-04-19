extends Node

@onready var game: Game = $Game
@onready var menu: Menu = $Menu

func _ready() -> void:
	set_level(0)


func _on_level_change(level: int) -> void:
	set_level(level)
	
	
func get_level_data(level_idx):
	var level_data = LevelData.new()
	level_data.unmarhshal(level_idx)
	return level_data


func set_level(level: int) -> void:
	print("Setting level: ", level)
	if level < 1:
		menu.show()
		game.hide()
	else:
		menu.hide()
		game.show()
		game.load_new_level(get_level_data(level))
