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
	
	print(typeof(pattern))
	
	return pattern

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
	for constellation in constellations:
		if constellation.is_complete(occupied_star_positions):
			print("yes")
			constellation.mark_completed()
			trigger_sky_crack()

		
# Triggering the sky count means 
# How many times 
func trigger_sky_crack() -> void:
	var completed_count = 0
	for c in constellations:
		if c.constellation_completed:
			completed_count += 1
	
	var crack_percentage: float = float(completed_count) / constellations.size() * 100.00
	# 
	
	if completed_count >= constellations.size():
		game_over()
		
	
func game_over():
	# Add an animation of 
	# the sky cracking
	
	print("GAME OVER - All constellations formed")
	
	# Then probably add like a UI here indicating for game over
