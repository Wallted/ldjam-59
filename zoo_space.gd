class_name ZooSpace
extends Control
@onready var tilemap = $TileMapLayer
const ANIMAL = preload("res://animal.tscn")
var rows_x = 4
var rows_y = 4

var scaled_size: Vector2
var _scale: float

func _ready() -> void:
	grid_generate()
	setup_animals([
		ANIMAL.instantiate(), ANIMAL.instantiate()
	])

func setup_animals(animals: Array[Animal]):
	for animal in animals:
		animal.zoo_space = self
		animal.position = Vector2(randi_range(0, scaled_size.x), randi_range(0, scaled_size.y))
		add_child(animal)

func grid_generate():
	tilemap.clear()
	
	var tile_size = tilemap.tile_set.tile_size
	
	var wanted_size_x = tile_size.x * rows_x
	var wanted_size_y = tile_size.y * rows_y
	var size_x = size.x
	var size_y = size.y
	
	_scale = minf(size_x / wanted_size_x, size_y / wanted_size_y)
	
	var offset_x = 0
	var offset_y = 0
	if size_x > (wanted_size_x * _scale):
		offset_x = (size_x - (wanted_size_x * _scale))/2
	if size_y > (wanted_size_y * _scale):
		offset_y = (size_y - (wanted_size_y * _scale))/2
	
	scaled_size = Vector2(wanted_size_x, wanted_size_y) * _scale
	
	tilemap.scale = Vector2(_scale, _scale)
	tilemap.position = Vector2(offset_x, offset_y)
	for x in rows_x:
		for y in rows_y:
			tilemap.set_cell(Vector2(x, y), 0, Vector2i(0, 0))

func grid_get_local_position(global_coords: Vector2):
	""" Posision relative to TileMap """

	var local_postion = global_position - global_coords + tilemap.position # why this works with global ?
	return -local_postion # why this needs to be negated ?

func grid_get_local_position_normalized(global_coords: Vector2) -> Vector2:
	""" Normalize each cell in grid to be between (0, 1)"""

	var local_postion = grid_get_local_position(global_coords)
	return local_postion / (Vector2(tilemap.tile_set.tile_size) * _scale)

func grid_process_cell(global_coords: Vector2):
	var local_postion = grid_get_local_position(global_coords)
	var cell_coords = tilemap.local_to_map(local_postion/tilemap.scale)
	tilemap.erase_cell(cell_coords)

func grid_is_in_bounds(global_coords: Vector2):
	var local_position = grid_get_local_position(global_coords)
	
	var rect = Rect2(Vector2.ZERO, Vector2.ZERO).expand(scaled_size)
	return rect.has_point(local_position) or global_coords == local_position
