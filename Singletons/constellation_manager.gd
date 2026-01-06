extends Node

"""
This is 2/3 of the constellation
series of scripts

The purpose of this script is to mainly
manage how the constellations get spawned,
counted, and reaction

"""

var all_stars: Array[Star] = []
var constellations: Array[Constellation] = []

# Shows the occupied star positions
var occupied_star_positions: Array[Vector2i] = []

signal constellation_completed(constellation: Constellation)
signal star_collected

# UI scenes
const game_over_ui = preload(Constants.SCENE_PATHS.game_over)

signal game_is_over

# Puts it in the star arary
func register_star(star: Star) -> void:
	all_stars.append(star)

# Generates the draft of the constellation
func generate_constellations(count: int = 1) -> Array[Constellation]:
	constellations.clear()
	
	var shapes_of_constellations = "triangle"
	for i in range(count):
		# Pick a random shape from constellations array
		var shape = shapes_of_constellations
		var positions = generate_shape_positions(shape)
		
		print(typeof(positions))
		
		var new_constellation = Constellation.new(i, shape, positions)
		constellations.append(new_constellation)
	
	return constellations
	
func generate_shape_positions(shape: String) -> Array[Vector2i]:
	# Generates the pattern and shape
	# of the selected constellation
	
	# Since we're spawning the stars
	# on here, we need to generate
	# each star position
	
	# Add a maximum number of attempts to
	# generate a shape
	
	var max_attempts = 100
	var current_no_attempts = 0
	
	while current_no_attempts <= max_attempts:
		current_no_attempts += 1
		
		var random_grid_x = randi_range(1, 18)
		var random_grid_y = randi_range(1, 10)
		
		
		# The center variable is the starting
		# point of the constellation  
		var center = Vector2i(random_grid_x, random_grid_y)
		var pattern: Array[Vector2i] = []
		
		match shape:
			# Add more shapes here
			# Once the triangle shape
			# Seems to be working
			"triangle":
				pattern.append(center)
				pattern.append(center + Vector2i(2,0))
				pattern.append(center + Vector2i(1,-2))
			
		if check_star_positions(pattern):
			return pattern
				
		print(typeof(pattern))
		
	print("Could not generate a valid constellation after ", max_attempts, " attempts")
	return [Vector2i(5,5), Vector2i(7,5), Vector2i(6,3)]

func check_star_positions(pattern: Array[Vector2i]) -> bool:
	for pos in pattern:
		if pos.x < 1 or pos.x > 18 or pos.y < 1 or pos.y > 10:
			return false
	return true

func grid_to_world(grid_pos: Vector2i, tile_size: int = 64) -> Vector2:
	return Vector2(grid_pos.x * tile_size + tile_size / 2, grid_pos.y * tile_size + tile_size / 2)

func star_occupied(star: Star):
	# Appends the star's position
	if star.is_occupied:
		occupied_star_positions.append(star.grid_position)
		star_collected.emit()
		
	check_constellations()


func star_vacated(star: Star):
	pass
	
func check_constellations():
	var all_completed = true
	for constellation in constellations:
		if not constellation.is_complete(occupied_star_positions):
			all_completed = false
			print("not yet complete!")
		else:
			constellation.marked_complete()
		
		if all_completed:
			trigger_sky_crack()

		
# Triggering the sky count means 
# How many times 
func trigger_sky_crack() -> void:
	var completed_count = 0
	for c in constellations:
		if c.constellation_completed:
			completed_count += 1
	
	var crack_percentage: float = float(completed_count) / constellations.size() * 100.00
	
	print(crack_percentage)
	
	if completed_count >= constellations.size():
		game_over()
		
func play_sky_crack_animations() -> void:
	pass
	# Play the animations

# Restart the entirety of the constellation
func game_reset() -> void:
	for constellation in get_children():
		constellation.queue_free()
	
	all_stars = []
	constellations= []
	occupied_star_positions= []
	
	# Also reset your dark matter resources
	GameResource.reset_dark_matter()
	
func game_over():
	# Get rid of everything
	await get_tree().create_timer(2.0).timeout
		
	await get_tree().process_frame
	
	# Add an animation of 
	# the sky cracking
	# in the game over ui
	game_is_over.emit()	
	game_reset()
	
	# Then probably add like a UI here indicating for game over
	
