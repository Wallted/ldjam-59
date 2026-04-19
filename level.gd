class_name Level
extends RefCounted

var x: int
var y: int

var player_choir: Array[Chorister] = []
var target_choir: Array[Chorister] = []

func _init(level_data: LevelData) -> void:
	x = level_data.x
	y = level_data.y
	
	var player_data  = level_data.player_data
	var target_data = level_data.target_data

	initialize_choir(player_data, target_data)

func initialize_choir(player_species, target_species):
	for data_arrays in [[player_species, player_choir], [target_species, target_choir]]:
		var species_array = data_arrays[0]
		var choir_array = data_arrays[1] 
		for item in species_array:
			var species = item[0]
			var freq = item[1]
			var chorister = Species.ChoristerMap[species].new(freq) 
			choir_array.append(chorister)
