class_name Choripracter
extends Chorister


func _specific_math():
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Choripracter"),1).set_wet((self.grid_position.y/self.grid_size.y/1.5+0.1))
	return sin(_phase * TAU)-cos(_phase * TAU*2) 
