class_name Main
extends Node
@export var tower_placer_manager: TowerPlacer = null
@export var highlight_tile: HighlightTile = null
@export var building_manager: BuildManager = null
@onready var tile_map_layer: TileMapLayer = $Foreground

var star_global_position: Vector2i

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
	print("Instantiating the pre-made constellations!")
	
	var constellation_array = ConstellationManager.generate_constellations()
	
	# Loop over each constellation
	for constellation in constellation_array:
		# Get each position of each stars
		var star_positions = constellation.get_star_positions()
		
		# Loop through each star position in the constellation
		for star_pos in star_positions:
			# Create a new star instance
			var star_scene = preload(Constants.SCENE_PATHS.star_scene)
			var star_instance = star_scene.instantiate()	
			
			# Use the position of the constellation
			star_instance.global_position = star_pos
			
			add_child(star_instance)
			$StarTracker.global_position = star_instance.global_position
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
		var star_grid_position: Vector2i = Vector2i(star_global_position / 64)

		if tower_placer_manager.selected_tower and cell_position != star_grid_position:
			building_manager.place_tower(cell_position, tower_placer_manager.selected_tower)
		# Maybe add a warning afterwards if they do place
		# That they cant place there?
		else:
			print_debug("No tower selected!")
