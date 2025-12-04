# This is the 3rd part of our tower manager
# TOWER BEHAVIOR

class_name BaseTower extends Node2D
@export var tower_range: float = 200.0

# For tower awareness
var enemies_in_range: Array = []
var current_target: Enemy = null

#Cooldown timer for attacking an enemy
@export var attack_cooldown: float = 1.0
var attack_timer: Timer

func _ready() -> void:
	attack_timer = Timer.new()
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = false 
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	attack_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""
	Our algorithm loks like this
	1. Give the tower an ability scan the area around us
	2. Get the stats of the class we're looking for
	3. Use those stats to define tower priority
	"""
	scan_for_enemies()
	update_target()
	
	#Goodbye losing target!
	if not current_target or not is_instance_valid(current_target):
		on_target_lost()
# This will vary from tower to tower
# We most likely need to setup a manager for this
# Since every tower has its own way of attacking
func _on_attack_timer_timeout() -> void:
	print("Timer fired!")
	if current_target and is_instance_valid(current_target):
		attack_enemies(current_target)

func attack_enemies(target: Enemy) -> void:
	pass

func on_target_lost() -> void:
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
				if enemy not in enemies_in_range:
					enemies_in_range.append(enemy)
			else:
				enemies_in_range.erase(enemy)
			
			
