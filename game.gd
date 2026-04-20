class_name Game
extends Control

@onready var audio: Audio = $Audio
@onready var zoo_space: ZooSpace = $ZooSpace
@onready var back_button: BackButton = $BackButton
@onready var current_fractal: Fractal = $CurrentFractal
@onready var target_fractal: Fractal = $TargetFractal
@onready var background = $Background
const UFO = preload("uid://cmtktioq7jdad")
@onready var led: Led = $Led

var level: Level
signal go_to_menu()

var rng = RandomNumberGenerator.new()

func _ready():
	back_button.pressed.connect(_exit_level)
	led.reset()

func load_new_level(level_data: LevelData) -> void:
	level = Level.new(level_data)
	audio.level = level
	zoo_space.level = level
	
	current_fractal.start(level)
	target_fractal.start(level)
	zoo_space.restart()
	led.reset()
	check_win_condition()
	

	for x in 8:
		for y in 5:
			background.set_cell(Vector2(x, y), rng.randi_range(0, 2), Vector2i(0, 0))

func _exit_level():
	current_fractal.stop()
	target_fractal.stop()
	go_to_menu.emit()


func _on_play_button(is_pressed: bool, is_player: bool):
	audio.who_sings = Audio.WhoSings.None
	if is_pressed:
		audio.who_sings = Audio.WhoSings.Player if is_player else Audio.WhoSings.Target
	if is_pressed and is_player:
		check_win_condition()
		
			
func ufo_cleanup():
	var ufo = UFO.instantiate()
	var screen = get_viewport_rect()
	ufo.position = screen.size + Vector2(50.0, -screen.size.y/2)
	ufo.fly_at(Vector2(-50.0, -50.0))
	add_child(ufo)

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
		print('glorp')
		led.enable()
		ufo_cleanup()
	else:
		print("glorpn't")
		led.disable()
	return is_solved;
