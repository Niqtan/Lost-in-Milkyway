class_name Enemy
extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var pathfinding_algorithm: PathFindingManager = null
@export var target_pos: Marker2D = null

# Enemy Health
@export var enemy_health: float = 200.0

# Path visualization
# Using Line2D
@onready var path_line: Line2D = Line2D.new()

var path_array: Array[Vector2i] = []

func _ready() -> void:
	path_line.width = 2
	path_line.default_color = Color.WHITE
	add_child(path_line)
	get_path_array()

func _process(delta: float) -> void:
	get_path_to_position()
	$AnimatedSprite2D.play("default")
	move_and_slide()
	
func get_path_array() -> void:
	var current_grid_pos: Vector2i = Vector2i(global_position / 64)
	var target_grid_pos: Vector2i = Vector2i(target_pos.position / 64)
	print("Enemy at grid pos: ", global_position / 64)
	path_array = pathfinding_algorithm.get_valid_path(current_grid_pos, target_grid_pos)
	
	visualize_path_array(path_array)
	
	if path_array.size() > 0:
		print(path_array[0])

func visualize_path_array(path_array: Array[Vector2i]) -> void:
	# Use white dots to visualize
	# the path array
	
	path_line.clear_points()
	
	for grid_position in path_array:
		#World position basically means the center of a tile
		var world_pos = Vector2(grid_position * 64 + Vector2(32, 32))
		path_line.add_point(world_pos - global_position)
	
		
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
	queue_free()
