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

# Puts it in the star arary
func register_star(star: Star) -> void:
	all_stars.append(star)

# Generates the draft of the constellation
func generate_constellations(count: int = 3):
	constellations.clear()
	
	var shapes_of_constellations = ["triangle"]
	for i in range(count):
		# Pick a random shape from constellations array
		var shape = shapes_of_constellations[i % shapes_of_constellations.size()]
		var positions = generate_shape_positions(shape)
		var new_constellation = Constellation.new(i, shape, positions)
		constellations.append(new_constellation)
		
func generate_shape_positions(shape: String) -> Array[Vector2i]:
	# Generates the pattern and shape
	# of the selected constellation
	
	var available_positions: Array[Vector2i] = []
	for star in all_stars:
		available_positions.append(star.grid_position)
	
	if available_positions.is_empty():
		return []
	
	# The center variable is the starting
	# point of the constellation  
	var center = available_positions.pick_random()
	var pattern: Array[Vector2i] = []
	
	match shape:
		# Add more shapes here
		# Once the triangle shape
		# Seems to be working
		"triangle":
			pattern = [center, center + Vector2i(2,0), center + Vector2i(1, -2)]
	return pattern

func star_occupied(star: Star):
	check_constellations()

func star_vacated(star: Star):
	pass
	
func check_constellations():
	# Checks if that star is already
	# Occupied by the enemy
	for star in all_stars:
		if star.is_occupied:
			occupied_star_positions.append(star.grid_position)
	
	# Checks if the constellation is already
	# a complete constellation
	
	# The reason why this is in the check constellation part
	# Is because we want to trigger the fact that the 
	# constellation manager should check
	# if all the stars have formed  a constellation 
	# or shape of some sort
	for constellation in constellations:
		if constellation.is_complete(occupied_star_positions):
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
