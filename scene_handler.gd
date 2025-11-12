class_name Main
extends Node
@onready var tower_placer_node = $"Gameplay UI/TowerPlacerManager"
@export var building_manager: BuildManager = null
@onready var tile_map_layer: TileMapLayer = $Foreground


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
		if tower_placer_node.selected_tower:
			building_manager.place_tower(cell_position, tower_placer_node)
		else:
			print_debug("No tower selected!")
