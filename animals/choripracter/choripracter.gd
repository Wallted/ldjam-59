class_name Choripracter
extends Chorister


func _specific_math():
	#AudioServer.get_bus_effect(AudioServer.get_bus_index("Choripracter"),1).set_wet((self.grid_position.y/self.grid_size.y/1.5+0.1))
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Choripracter"),1).set_wet(((EFFECT_MAX_GRID_SIZE - self.grid_position.y)/EFFECT_MAX_GRID_SIZE/1.5+0.1))
	return sin(_phase * TAU)-cos(_phase * TAU*2) 
