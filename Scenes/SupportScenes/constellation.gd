class_name Constellation
extends RefCounted

"""
This is 1/3 of the constellation
series of scripts

This script mainly focuses on
initializing the needed  riables
in making the constellation 
gameplay 

"""

var id: int
var star_positions: Array[Vector2i] = []
var shape: String
var line_renderer: Line2D = null

var constellation_completed = false

func _init(constellation_id: int, constellation_shape: String, positions: Array[Vector2i]) -> void:
	id = constellation_id
	shape = constellation_shape
	star_positions = positions

func get_star_positions() -> Vector2i:
	for position in star_positions:
		return position
	return Vector2i.ZERO
	
func is_complete(occupied_positions: Array[Vector2i]) -> bool:
	if occupied_positions.size() >= 3:
		return true
	else:
		return false

func marked_complete():
	constellation_completed = true
	print("Constellation of id: ", id, "shape_type: ", shape, "completed!")
