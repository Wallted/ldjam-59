class_name Qudratoppator
extends Chorister


func _specific_math():
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Qudratoppator"),2).set_cutoff((self.grid_position.y/self.grid_size.y*10000+400))
	return fmod(_phase*TAU,3)-fmod(_phase*TAU,12)#+sin(_phase*TAU)
