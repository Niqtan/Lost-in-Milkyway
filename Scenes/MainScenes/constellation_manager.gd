extends Node

"""

This is an autoload for constellation manager
"""

var all_stars: Array[Star] = []
var constellations = Array[Constellation] = []

# Puts it in the star arary
func register_star(star: Star) -> void:
	all_stars.append(star)

# Generates the draft of the constellation
func generate_constellations(count: int = 3):
	pass

func generate_shape_positions() -> Array[Vector2i]
