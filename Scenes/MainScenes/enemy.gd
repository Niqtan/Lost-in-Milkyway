class_name Enemy
extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var pathfinding_algorithm: PathFindingManager = null
@export var target_pos: Marker2D = null

var path_array: Array[Vector2i] = []

func _ready() -> void:
	path_array = pathfinding_algorithm.get_valid_path(global_position / 16, target_pos.position / 16)
	
func _process(delta: float) -> void:
	get_path_to_position()
	move_and_slide()
	
func get_path_to_position() -> void:
	if len(path_array) > 0:
		var direction: Vector2 = global_position.direction_to(path_array[0])
		
		velocity = direction * movement_speed
		
		if global_position.distance_to(path_array[0]) <= 10:
			path_array.remove_at(0) 
	else:
		velocity = Vector2.ZERO
	
