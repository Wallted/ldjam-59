extends Node

@onready var game: Game = $Game
@onready var menu: Menu = $Menu


func _ready() -> void:
	show_menu()


func show_menu():
	set_level(0)


func _on_level_change(level_idx: int) -> void:
	set_level(level_idx)
	
	
func _on_win(level_idx: int) -> void:
	self.menu.update_i_na_chate(level_idx)


func get_level_data(level_idx):
	var level_data = LevelData.new()
	level_data.unmarhshal(level_idx)
	return level_data


func set_level(level_idx: int) -> void:
	print("Setting level: ", level_idx)
	if level_idx < 1:
		menu.show()
		game.hide()
	else:
		menu.hide()
		game.show()
		var level_data = get_level_data(level_idx)
		level_data.solved = menu.is_level_completed(level_idx)
		game.load_new_level(level_data)
