class_name UfoCruiseControl
extends PathFollow2D

var flying = false
@onready var ufo: UFO = $UFO

@export var points = [
	[0.0, -0.7],
	[1.0, 0.0],
	[1.0, 3.0],
	#[0.2, 0.0],
	#[1.2, 6.0],
	#[1.8, -5.0],
	#[2.4, 5.0],
	#[3.2, -6.0],
	#[3.8, 0.0],
]

@export var starting_speed := 0.2
var elapsed_time := 0.0
var current_speed := 1.0
var position_ratio := 0.0

func _ready() -> void:
	restart()
	hide()
	flying = false
	
func _process(delta):
	ufo.flip_v = cos(rotation) >= 0
	if flying:
		elapsed_time += delta

		var acceleration = acceleration_at(elapsed_time)
		current_speed += acceleration * delta
		position_ratio = clamp(position_ratio + current_speed * delta, 0.0, 1.0)

		progress_ratio = position_ratio

func acceleration_at(time_in_seconds):
	for i in range(points.size() - 1):
		var left_point = points[i]
		var right_point = points[i + 1]
		if time_in_seconds >= left_point[0] and time_in_seconds < right_point[0]:
			return left_point[1]
	return points[-1][1]
	


func restart():
	show()
	elapsed_time = 0.0
	current_speed = 1.0
	position_ratio = 0.0
	flying = true
	loop = false
	rotates = false
