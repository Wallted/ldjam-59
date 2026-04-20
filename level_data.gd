class_name LevelData
extends RefCounted

var x: int
var y: int

var offset: Vector2

var player_data: Array # [species, x, y]
var target_data: Array # [species, x, y]

func marshal() -> String:
	var data = {
		'x': x,
		'y': y,
		'offset_x': offset.x,
		'offset_y': offset.y,
		'player_data': player_data,
		'target_data': target_data,
	}
	return JSON.stringify(data)

func unmarhshal(level_idx: int) -> void:
	var level_data = load("res://levels/%02d.json" % level_idx).data

	x = level_data['x']
	y = level_data['y']
	offset = Vector2(level_data['offset_x'], level_data['offset_y'])
	player_data = level_data['player_data']
	for item in player_data:
		item[0] = int(item[0])
	target_data = level_data['target_data']
	for item in target_data:
		item[0] = int(item[0])
