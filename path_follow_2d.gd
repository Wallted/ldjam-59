class_name UfoCruiseControl
extends PathFollow2D


var SPEED = 1000.0


var flying = false


func _ready() -> void:
	flying = false
	loop = false
	
func _process(delta):
	if flying:
		progress += SPEED * delta
	if progress_ratio >= 1.0:
		hide()


func restart():
	show()
	flying = true
	progress = 0.0
