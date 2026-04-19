class_name Menu
extends Control

@onready var level_container: FlowContainer = $LevelContainer
const LEVEL_BUTTON = preload("uid://gbudv1i2une2")


signal on_level_change(level_number: int)  # 0=menu

var LEVELS_COUNT = 2

func _ready() -> void:
	var side_length = ceil(sqrt(LEVELS_COUNT));
	var cell_size = level_container.size / side_length - Vector2(20, 20);
	var i = 0
	for level_idx in LEVELS_COUNT:
		i += 1
		var button = LEVEL_BUTTON.instantiate()
		button.custom_minimum_size = cell_size
		button.pressed.connect(change_level.bind(button))
		button.text = str(i)
		button.level_idx = i
		button.show()
		level_container.add_child(button)


func change_level(button: LevelButton) -> void:
	print(button)
	on_level_change.emit(button.level_idx)
