class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace
@onready var back_button: BackButton = $BackButton
@onready var current_fractal: Fractal = $CurrentFractal
@onready var target_fractal: Fractal = $TargetFractal
@onready var background = $Background

var level: Level
signal go_to_menu()

var rng = RandomNumberGenerator.new()

func _ready():
	back_button.pressed.connect(_exit_level)

func load_new_level(level_data: LevelData) -> void:
	level = Level.new(level_data)
	audio.level = level
	zoo_space.level = level
	
	current_fractal.start(level)
	target_fractal.start(level)
	zoo_space.restart()

	for x in 8:
		for y in 5:
			background.set_cell(Vector2(x, y), rng.randi_range(0, 3), Vector2i(0, 0))

func _exit_level():
	current_fractal.stop()
	target_fractal.stop()
	go_to_menu.emit()


func _on_play_button(is_pressed: bool, is_player: bool):
	audio.who_sings = Audio.WhoSings.None
	if is_pressed:
		audio.who_sings = Audio.WhoSings.Player if is_player else Audio.WhoSings.Target
