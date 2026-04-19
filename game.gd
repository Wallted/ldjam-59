class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace
@onready var back_button: BackButton = $BackButton

var level: Level
signal go_to_menu()

func _ready():
	back_button.pressed.connect(func(): go_to_menu.emit())

func load_new_level(level_data: LevelData) -> void:
	level = Level.new(level_data)
	audio.level = level
	zoo_space.level = level
	
	zoo_space.restart()

func _on_play_button(is_pressed: bool, is_player: bool):
	audio.who_sings = Audio.WhoSings.None
	if is_pressed:
		audio.who_sings = Audio.WhoSings.Player if is_player else Audio.WhoSings.Target
