class_name Level
extends RefCounted

enum ChoristerSpecies {
	SINOCEROS,
}

var ChoristerMap = {
	ChoristerSpecies.SINOCEROS: Sinoceros,
}

var x = 30
var y = 20

var player_choir: Array[Chorister] = []
var target_choir: Array[Chorister] = []

func _init() -> void:
	var player_data = [ # mock
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
	]
	var target_data = [ # mock
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
		[ChoristerSpecies.SINOCEROS, 200.0],
	]
	initialize_choir(player_data, target_data)

func initialize_choir(player_species, target_species):
	for data_arrays in [[player_species, player_choir], [target_species, target_choir]]:
		var species_array = data_arrays[0]
		var choir_array = data_arrays[1] 
		for item in species_array:
			var species = item[0]
			var freq = item[1]
			var chorister = ChoristerMap[species].new(freq) 
			choir_array.append(chorister)
