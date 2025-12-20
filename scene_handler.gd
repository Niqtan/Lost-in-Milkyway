class_name Main
extends Node
@export var tower_placer_manager: TowerPlacer = null
@export var highlight_tile: HighlightTile = null
@export var building_manager: BuildManager = null
@export var wave_manager: WaveManager = null
@onready var tile_map_layer: TileMapLayer = $Foreground

var array_of_star_positions: Array[Vector2i] = []

func _ready() -> void:
	setup_star_gameplay()
	wave_manager.start_wave()
	
	
func _process(delta: float) -> void:
	var current_highlighted_tower = null
	if tower_placer_manager.selected_tower != current_highlighted_tower:
		current_highlighted_tower = tower_placer_manager.selected_tower
		# Add the tower being selected here
		if current_highlighted_tower:
			highlight_tile.set_sprite(tower_placer_manager.selected_tower)

var current_star_index = 0
var current_constellation_stars = []
func setup_star_gameplay():
	print("Instantiating the pre-made constellations!")
	
	var constellation_array = ConstellationManager.generate_constellations()
	
	ConstellationManager.star_collected.connect(_on_star_collected)
	# Loop over each constellation
	for constellation in constellation_array:
		# Get each position of each stars
		var star_positions = constellation.get_star_positions()
		print(typeof(star_positions))
		
		# Loop through each star position in the constellation
		for star_pos in star_positions:
			array_of_star_positions.append(star_pos)
			# Create a new star instance
			var star_scene = preload(Constants.SCENE_PATHS.star_scene)
			var star_instance = star_scene.instantiate()	
			
			# Use the position of a random star
			# in the pre-made constellation
			star_instance.global_position = ConstellationManager.grid_to_world(star_pos)
			
			add_child(star_instance)
			current_constellation_stars.append(star_instance)
			
		if current_constellation_stars.size() > 0:
			$StarTracker.global_position = current_constellation_stars[0].global_position

func _on_star_collected():
	current_star_index += 1
	if current_star_index < current_constellation_stars.size():
		$StarTracker.global_position = current_constellation_stars[current_star_index].global_position
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
		
		for star_pos in array_of_star_positions:
			if tower_placer_manager.selected_tower and cell_position != star_pos:
				building_manager.place_tower(cell_position, tower_placer_manager.selected_tower)
			# Maybe add a warning afterwards if they do place
			# That they cant place there?
			else:
				print_debug("No tower selected!")
