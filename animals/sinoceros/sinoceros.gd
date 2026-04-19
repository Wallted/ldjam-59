class_name Sinoceros
extends Chorister


func _specific_math():
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Sinoceros"),1).set_rate_hz((self.grid_position.y/self.grid_size.y*10+1))
	return sin(_phase * TAU)
