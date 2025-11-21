# This is the 3rd part of our tower manager
# TOWER BEHAVIOR
extends Node2D

@export var tower_range: float = 200.0
var enemies_in_range: Array = []
var current_target: Enemy = null



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Look around a certain distance
	# And then find out if the class is an enemy
	print("Scanning for enemies...")
	scan_for_enemies()
	
	
	"""
	Our algorithm loks like this
	1. Give the tower an ability scan the area around us
	2. Get the stats of the class we're looking for
	3. Use those stats to define tower priority
	"""


# This will vary from tower to tower
# We most likely need to setup a manager for this
# Since every tower has its own way of attacking
func attack_enemies() -> void:
	
	$Sprite2D

func scan_for_enemies() -> void:
	enemies_in_range.clear()
	
	var all_enemies = get_tree().get_nodes_in_group("units")
	
	for enemy in all_enemies:
		if enemy is Enemy:
			var distance = global_position.distance_to(enemy.global_position)
			if distance <= tower_range:
				enemies_in_range.append(enemy)
				print("Enemy scanned!")
			else:
				print("No enemies scanned!")
