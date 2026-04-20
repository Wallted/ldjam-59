class_name UFO
extends AnimatedSprite2D

var destination: Vector2 = Vector2.ZERO


var SPEED: float = 200.0


func _process(delta):
	var distance_to_destination
	var distance_to_move
	if position != destination:
		self.play()
		distance_to_destination = position.distance_to(destination)
		distance_to_move = SPEED * delta
		if abs(distance_to_destination) < abs(distance_to_move):
			distance_to_move = distance_to_destination
		position += position.direction_to(destination) * distance_to_move
	else:
		self.hide()


func fly_at(_destination: Vector2):
	self.destination = _destination
	self.show()
