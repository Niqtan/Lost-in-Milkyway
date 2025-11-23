# This is the 3rd part of our tower manager
# TOWER BEHAVIOR

class_name BaseTower extends Node2D
@export var tower_range: float = 200.0

# For tower awareness
var enemies_in_range: Array = []
var current_target: Enemy = null

#Cooldown timer for attacking an enemy
@export var attack_cooldown: float = 1.0
var cooldown_timer: float = 0.0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""
	Our algorithm loks like this
	1. Give the tower an ability scan the area around us
	2. Get the stats of the class we're looking for
	3. Use those stats to define tower priority
	"""
	print("Scanning for enemies...")
	scan_for_enemies()
	update_target()
	
	if current_target: 
		cooldown_timer -= delta
		if cooldown_timer <= 0:
			print(current_target)
			attack_enemies(current_target)
			cooldown_timer = attack_cooldown

# This will vary from tower to tower
# We most likely need to setup a manager for this
# Since every tower has its own way of attacking
func attack_enemies(target: Enemy) -> void:
	pass

func update_target() -> void:
	"""Selects and validates the current target, and also tracks them"""
	
	if current_target:
		# Checks if its alive anymore
		if not is_instance_valid(current_target) or not current_target in enemies_in_range:
			current_target = null
		
	if not current_target and enemies_in_range.size() > 0:
		current_target = select_target()

func select_target() -> Node2D:
	"""Targetting priority logic"""
	if enemies_in_range.is_empty():
		return null
	
	# Closest enemy	
	var closest = enemies_in_range[0]
	var closest_distance = global_position.distance_to(closest.global_position)
	
	# This loop is for to scan the enemy array
	# for the closest enemy (does extra checks)
	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		
		if distance < closest_distance:
			closest_distance = distance
			closest = enemy
	
	return closest
	
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
