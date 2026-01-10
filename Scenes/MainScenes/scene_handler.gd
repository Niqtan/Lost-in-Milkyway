class_name Main
extends Node
@export var tower_placer_manager: TowerPlacer = null
@export var highlight_tile: HighlightTile = null
@export var building_manager: BuildManager = null
@export var wave_manager: WaveManager = null
@onready var tile_map_layer: TileMapLayer = $Foreground

var array_of_star_positions: Array[Vector2i] = []

func _ready() -> void:	
	ConstellationManager.star_collected.connect(_on_star_collected)
	ConstellationManager.constellation_completed.connect(_on_constellation_completed)
	
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
var current_constellation_index
var constellation_array: Array[Constellation] = []
var current_constellation_stars = []

var collected_stars: Array[Node2D] = []
var closest_dist_sq = INF
var closest_star_to_enemy: Node2D = null

func setup_star_gameplay():	
	constellation_array = ConstellationManager.generate_constellations()
	
	spawn_constellation(0)

func spawn_constellation(index: int):
	if index >= constellation_array.size():
		print("All constellations have been spawned!")
		return
	
	clear_current_constellation()
	# function to clean all constellations in the scene
	
	# Need to show first constellation only
	# Get each position of each stars
	var constellation = constellation_array[index]
	var star_positions = constellation.get_star_positions()
			
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
		
		var world_pos = ConstellationManager.grid_to_world(star_pos)
		var dist_sq = world_pos.distance_squared_to($SpawnPoint.global_position)
		
		if dist_sq < closest_dist_sq:
			closest_dist_sq = dist_sq
			closest_star_to_enemy = star_instance
		
	if closest_star_to_enemy:
		current_star_index = current_constellation_stars.find(closest_star_to_enemy)
		$StarTracker.global_position = closest_star_to_enemy.global_position
	
	current_constellation_index = index

func clear_current_constellation():
	for star in current_constellation_stars:
		star.queue_free()
	
	current_constellation_stars.clear()
	array_of_star_positions.clear()	

func _on_constellation_completed():
	current_constellation_index += 1
	spawn_constellation(current_constellation_index)

func _on_star_collected():
	collected_stars.append(closest_star_to_enemy)	
	
	# Reset each time
	closest_dist_sq = INF
	
	for star in current_constellation_stars:
		if star in collected_stars:
			continue
		var dist_sq = star.global_position.distance_squared_to($SpawnPoint.global_position)
			
		if dist_sq < closest_dist_sq:
			closest_dist_sq = dist_sq
			closest_star_to_enemy = star
	if closest_star_to_enemy:
		$StarTracker.global_position = closest_star_to_enemy.global_position
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var cell_position: Vector2i = tile_map_layer.local_to_map(tile_map_layer.get_local_mouse_position())
	
		if tower_placer_manager.selected_tower and cell_position not in array_of_star_positions:
			building_manager.place_tower(cell_position, tower_placer_manager.selected_tower, tower_placer_manager.tower_cost)
		# Maybe add a warning afterwards if they do place
		# That they cant place there?
		else:
			print_debug("No tower selected!")
