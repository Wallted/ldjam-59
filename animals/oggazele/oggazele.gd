class_name Oggazele
extends Chorister


func _specific_math():
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Oggazele"),2).set_drive((self.grid_position.y/self.grid_size.y/2+0.45))
	return sin(_phase * TAU)-sin(_phase * TAU*2)  
