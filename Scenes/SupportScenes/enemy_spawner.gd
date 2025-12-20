"""
# I think what's going to separate
this from the wave manager is just
one simple sentence,

"I know where and how to spawn" 
"""

class_name EnemySpawner
extends Node2D


# Spawn the enemies
@export var enemy_scene: PackedScene
@onready var enemies_container = get_node("../../Enemies")


# Spawns the enemy at the enemy spawner at the timing of it being called
func spawn_enemy(enemy_health: int, enemy_speed: float) -> void:

	
	var enemy = enemy_scene.instantiate()
	enemy.pathfinding_algorithm = $"../../PathFindingManager"
	enemy.target_pos = $"../../StarTracker"
	
	# always adjust enemy stats according
	# to wave data array
	
	enemy.enemy_health = enemy_health
	enemy.movement_speed = enemy_speed
	
	enemy.enemy_died.connect(get_parent()._on_enemy_died)
	
	enemies_container.add_child(enemy)
	enemy.global_position = $"../../SpawnPoint".global_position
	
