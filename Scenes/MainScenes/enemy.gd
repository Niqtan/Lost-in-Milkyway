class_name Enemy
extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var pathfinding_algorithm: PathFindingManager = null

@export var target_pos: Marker2D = null
var last_target_position: Vector2

# Enemy Health
@export var enemy_health: float = 200.0

# Path visualization
# Using Line2D
@onready var path_line: Line2D = Line2D.new()
var path_array: Array[Vector2] = []

# For the star gameplay
var current_star: Star = null

# Signal for enemy dying
signal enemy_died

func _ready() -> void:
	path_line.width = 5
	path_line.default_color = Color.WHITE
	path_line.z_index = 100
	add_child(path_line)
	
	get_path_array()
	if target_pos:
		last_target_position = target_pos.position
	
func _process(delta: float) -> void:
	if target_pos and target_pos.position != last_target_position:
		last_target_position = target_pos.position
		get_path_array()
	

	get_path_to_position()
	visualize_path_array(path_array)
	$AnimatedSprite2D.play("default")
	move_and_slide()

func occupy_star(star: Star):
	current_star = star
	star.occupy(self)

func _on_left_target_pos():
	if current_star:
		current_star.vacate()
		current_star = null

func get_path_array() -> void:
	var current_grid_pos: Vector2i = Vector2i(global_position / 64)
	var target_grid_pos: Vector2i = Vector2i(target_pos.position / 64)
	var grid_path = pathfinding_algorithm.get_valid_path(current_grid_pos, target_grid_pos)
	
	# Convert to world path
	path_array = []
	
	for grid_pos in grid_path:
		var world_pos = Vector2(grid_pos) * 64 + Vector2(32, 32)
		path_array.append(world_pos)
	
	if path_array.size() > 0:
		print(path_array[0])

func visualize_path_array(path_array: Array[Vector2]) -> void:
	# Use white dots to visualize
	# the path array
		
	path_line.clear_points()
	
	for world_position in path_array:
		#World position basically means the center of a tile
		var local_pos = Vector2(world_position) - global_position
		path_line.add_point(local_pos)
		
		
func get_path_to_position() -> void:
	if len(path_array) > 0:
		var direction: Vector2 = global_position.direction_to(path_array[0])
		velocity = direction * movement_speed
		
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0) 
	else:
		velocity = Vector2.ZERO
	
# Enemy stats

func take_damage(damage: float):
	enemy_health -= damage
	print("Enemy health: ", enemy_health)
	
	if enemy_health <= 0:
		
		enemy_die()
	
func enemy_die():
	enemy_died.emit()
	queue_free()
	
# Star
func check_star_occupation():
	pass
