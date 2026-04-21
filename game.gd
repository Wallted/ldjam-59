class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var win_stream: AudioStreamPlayer = $Audio/Win_audio_stream
@onready var zoo_space: ZooSpace = $ZooSpace
@onready var back_button: BackButton = $BackButton
@onready var current_fractal: Fractal = $CurrentFractal
@onready var target_fractal: Fractal = $TargetFractal
@onready var ufo_group: Node2D = $UfoGroup
@onready var ufo_cruise_control: UfoCruiseControl = $UfoGroup/UfoPath/UfoCruiseControl
@onready var led: Led = $Led

var level: Level
signal go_to_menu()
signal win()

func _ready():
	zoo_space.on_animal_dropped = on_animal_dropped
	zoo_space.on_animal_dragged = on_animal_dragged
	back_button.pressed.connect(_exit_level)
	led.reset()
	

func load_new_level(level_data: LevelData) -> void:
	ufo_cruise_control.hide()
	level = Level.new(level_data)
	audio.level = level
	zoo_space.level = level
	
	current_fractal.start(level)
	target_fractal.start(level)
	zoo_space.restart()
	led.reset()
	if level_data.solved:
		led.enable()
	led.disable()
	win_stream.stop()

func _exit_level():
	current_fractal.stop()
	target_fractal.stop()
	go_to_menu.emit()


func _on_play_button(is_pressed: bool, is_player: bool):
	audio.who_sings = Audio.WhoSings.None
	if not is_pressed:
		return
	if is_player:
		audio.who_sings = Audio.WhoSings.Player
		target_fractal.unpress_button()
	else:
		audio.who_sings = Audio.WhoSings.Target
		current_fractal.unpress_button()
		
func on_animal_dragged(chorister_idx):
	led.disable()
	if audio.who_sings == Audio.WhoSings.None:
		audio.who_sings = Audio.WhoSings.Solo
		audio.set_solo_chorister(chorister_idx)

func on_animal_dropped():
	if audio.who_sings == Audio.WhoSings.Solo:
		audio.who_sings = Audio.WhoSings.None
	check_win_condition()
	
func ufo_deploy():
	win_stream.play(0.0)
	ufo_cruise_control.restart()
	
func check_win_condition():
	var is_solved = true;
	var player_choir = zoo_space.level.player_choir;
	var target_choir = zoo_space.level.target_choir;
	for i in min(len(player_choir), len(target_choir)):
		var player_chorist = player_choir[i];
		var target_chorist = target_choir[i];
		if (
			int(player_chorist.grid_position.x) != int(target_chorist.grid_position.x)
			or int(player_chorist.grid_position.y) != int(target_chorist.grid_position.y)
		):
			is_solved = false;
	if is_solved:
		led.enable()
		if not level.solved:
			ufo_deploy()
			level.solved = true
		win.emit(level.idx)
	else:
		led.disable()
	return is_solved;
