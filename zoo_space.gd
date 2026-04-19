class_name ZooSpace
extends Control

const GRID_ANIMAL = preload("res://grid_animal.tscn")

@onready var tilemap = $TileMapLayer

@export var rows_x = 4
@export var rows_y = 4

var grid_size_scaled: Vector2

var level: Level

func _ready() -> void:
	pass

func initialize():
	grid_generate()
	spawn_animals(level.player_choir)

func spawn_animals(choristers: Array[Chorister]):
	for chorister in choristers:
		chorister.grid_animal = GRID_ANIMAL.instantiate()
		chorister.grid_animal.zoo_space = self
		chorister.grid_animal.position = Vector2(randi_range(0, int(grid_size_scaled.x)), randi_range(0, int(grid_size_scaled.y)))
		add_child(chorister.grid_animal)

func grid_generate():
	var tile_size = tilemap.tile_set.tile_size
	var wanted_size_x = tile_size.x * rows_x
	var wanted_size_y = tile_size.y * rows_y
	var wanted_scale = minf(size.x / wanted_size_x, size.y / wanted_size_y)
	grid_size_scaled = Vector2(wanted_size_x, wanted_size_y) * wanted_scale
	
	var offset_x = 0
	var offset_y = 0
	if size.x > (wanted_size_x * wanted_scale):
		offset_x = (size.x - (wanted_size_x * wanted_scale))/2
	if size.y > (wanted_size_y * wanted_scale):
		offset_y = (size.y - (wanted_size_y * wanted_scale))/2
	
	tilemap.clear()
	tilemap.scale = Vector2(wanted_scale, wanted_scale)
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
	return local_postion / (Vector2(tilemap.tile_set.tile_size) * tilemap.scale)

func grid_is_in_bounds(global_coords: Vector2):
	var local_position = grid_get_local_position(global_coords)
	var rect = Rect2(Vector2.ZERO, Vector2.ZERO).expand(grid_size_scaled)
	return rect.has_point(local_position) or global_coords == local_position
	
func grid_get_cell_coords(global_coords: Vector2) -> Vector2i:
	var local_postion = grid_get_local_position(global_coords)
	return tilemap.local_to_map(local_postion/tilemap.scale)
	
# trash
func grid_process_cell(global_coords: Vector2):
	tilemap.erase_cell(grid_get_cell_coords(global_coords))
