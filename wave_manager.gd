"""
# I think what's going to separate
this from the enemy spawner is just
one simple sentence,

"I know when and how often to spawn" 
"""

class_name WaveManager
extends Node2D

signal spawning_phase_complete

#Allow the default_spawn_delay to be editable
@export var default_spawn_delay: float = 1.0
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer

# The Packed tower scene in question when	
# we want to spawn, then it would refer
# to this scene
@export var enemy_spawner: EnemySpawner = null

var current_spawn_delay: float = 0.0
var current_data_index: int = 0

func _ready() -> void:
	current_spawn_delay = default_spawn_delay
	
	enemy_spawn_timer.wait_time = current_spawn_delay
	
	enemy_spawn_timer.start()
	

func _on_enemy_spawn_timer_timeout() -> void:
	# print_debug("Enemy spawned! Time: %s" % current_spawn_delay)
	var continue_wave = enemy_spawner.spawn_enemy(current_data_index)
	
	if continue_wave:
		current_data_index += 1
	else:
		# printerr("Game Complete!")
		enemy_spawn_timer.stop()
		spawning_phase_complete.emit()
	
