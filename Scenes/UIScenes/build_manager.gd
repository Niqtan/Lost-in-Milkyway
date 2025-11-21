# This is the 2nd part of our tower managers
# TOWER PLACER

class_name BuildManager
extends Node2D

@export var tile_map_layer: TileMapLayer = null 


const is_buildable: String = "buildable"
const TOWER_GROUP: String = "TOWER_GROUP"

var used_tiles: Array[Vector2i] = []

# Building is not working
func place_tower(cell_position: Vector2i, tower_packed_scene: PackedScene) -> void:
	if check_valid_tower_placement(cell_position) == false:
		return
	
	var new_tower: Node2D = tower_packed_scene.instantiate()
	add_child(new_tower)
	
	new_tower.position = cell_position * 64 #Sets the position of the tower
	new_tower.z_index = 1 # Puts the tower in front
	new_tower.add_to_group(TOWER_GROUP)
	used_tiles.append(cell_position)
	
func check_valid_tower_placement(cell_position: Vector2i) -> bool:
	if used_tiles.has(cell_position):
		print_debug("Cannot place a troop here anymore")
		return false 

	var cell_data = tile_map_layer.get_cell_tile_data(cell_position).get_custom_data(is_buildable)

	# Check if cell is buildable
	return cell_data
