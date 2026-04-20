extends Node

@onready var game: Game = $Game
@onready var menu: Menu = $Menu
@onready var background = $Background


var level_data_array: Array[LevelData] = []

func _ready() -> void:
	show_menu()
	var rng = RandomNumberGenerator.new()
	for x in 8:
		for y in 5:
			background.set_cell(Vector2(x, y), rng.randi_range(0, 2), Vector2i(0, 0))

	for i in menu.LEVELS_COUNT:
		level_data_array.append(get_level_data(i+1))
	menu.set_animal_faces(level_data_array)

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
		var level_data = level_data_array[level_idx-1]
		level_data.solved = menu.is_level_completed(level_idx)
		game.load_new_level(level_data)
