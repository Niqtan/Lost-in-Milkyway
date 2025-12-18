"""
# I think what's going to separate
this from the wave manager is just
one simple sentence,

"I know where and how to spawn" 
"""

class_name EnemySpawner
extends Node2D

@export var wave_data_array: Array = ["Enemy 1", "Enemy 2" , "Enemy 3"  , "Enemy 4"  ]

# Spawn the enemies
@export var enemy_scene: PackedScene
@onready var enemies_container = get_node("../../Enemies")

# Spawns the enemy at the enemy spawner at the timing of it being called
func spawn_enemy(current_data_index: int) -> bool:
	if current_data_index >= wave_data_array.size():
		# If there are no more enemies,
		# wave is done
		return false
	
	
	var enemy = enemy_scene.instantiate()
	enemies_container.add_child(enemy)
	enemy.global_position = $"../../Enemies/Enemy".global_position
	
	# If there are more enemies,
	# continue spawning
	# print_debug(wave_data_array[current_data_index])
	return true
