class_name Enemy
extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var pathfinding_algorithm: PathFindingManager = null
@export var target_pos: Marker2D = null

# Enemy Health
@export var enemy_health: float = 200.0



var path_array: Array[Vector2i] = []

func _ready() -> void:
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
	
	if path_array.size() > 0:
		print(path_array[0])

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
