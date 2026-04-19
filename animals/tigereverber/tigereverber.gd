class_name Tigereverber
extends Chorister


func _specific_math():
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Tigereverber"),2).set_wet((self.grid_position.y/self.grid_size.y))
	return sin(_phase * TAU*1.2)+sin(_phase * TAU*2)
