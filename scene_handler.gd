class_name Main
extends Node
@export var tower_placer_manager: TowerPlacer = null
@export var highlight_tile: HighlightTile = null
@export var building_manager: BuildManager = null
@onready var tile_map_layer: TileMapLayer = $Foreground



func _ready() -> void:
	setup_star_gameplay()
	
func _process(delta: float) -> void:
	var current_highlighted_tower = null
	if tower_placer_manager.selected_tower != current_highlighted_tower:
		current_highlighted_tower = tower_placer_manager.selected_tower
		# Add the tower being selected here
		if current_highlighted_tower:
			highlight_tile.set_sprite(tower_placer_manager.selected_tower)

func setup_star_gameplay():
	var star_scene = preload(Constants.SCENE_PATHS.lightning_attack)
	var star_instance = star_scene.instantiate()
	add_child(star_instance)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
		if tower_placer_manager.selected_tower:
			building_manager.place_tower(cell_position, tower_placer_manager.selected_tower)
		else:
			print_debug("No tower selected!")
