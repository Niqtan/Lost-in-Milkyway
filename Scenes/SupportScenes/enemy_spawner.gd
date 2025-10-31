"""
# I think what's going to separate
this from the wave manager is just
one simple sentence,

"I know where and how to spawn" 
"""

class_name EnemySpawner
extends Node2D

@export var wave_data_array: Array = ["Enemy 1", "Enemy 2" , "Enemy 3"  , "Enemy 4"  ]


# Spawns the enemy at the enemy spawner at the timing of it being called
func spawn_enemy(current_data_index: int) -> bool:
	if current_data_index >= wave_data_array.size():
		return false
	
	# print_debug(wave_data_array[current_data_index])
	return true
