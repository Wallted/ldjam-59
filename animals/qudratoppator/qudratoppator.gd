class_name Qudratoppator
extends Chorister


func _specific_math():
	#AudioServer.get_bus_effect(AudioServer.get_bus_index("Qudratoppator"),2).set_cutoff((self.grid_position.y/self.grid_size.y*10000+400))
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Qudratoppator"),2).set_cutoff(((EFFECT_MAX_GRID_SIZE - self.grid_position.y)/EFFECT_MAX_GRID_SIZE*10000+400))
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Qudratoppator"),5).set_wet(((EFFECT_MAX_GRID_SIZE-(EFFECT_MAX_GRID_SIZE - self.grid_position.y))/EFFECT_MAX_GRID_SIZE+0.0))
	return fmod(_phase*TAU,3)-fmod(_phase*TAU,12)#+sin(_phase*TAU)
