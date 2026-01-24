"""
# I think what's going to separate
this from the enemy spawner is just
one simple sentence,

"I know when and how often to spawn" 
"""

class_name WaveManager
extends Node

signal wave_changed(wave_numbers: int,current_wave_num: int )
signal spawning_phase_complete

#Allow the default_spawn_delay to be editable
@export var default_spawn_delay: float = 1.0
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer

# The Packed tower scene in question when	
# we want to spawn, then it would refer
# to this scene
@onready var enemy_spawner: EnemySpawner = $"Enemy Spawner"

var current_data_index: int = 0
var enemies_alive_in_wave: int = 0

# The number of waves will depend
# on the difficulty of a single map
# For now, we'll make it to 5
var number_of_waves: int = 4
var current_number_of_waves: int = 0
@export var wave_data_array: Array = []

# Variables to manipulate
@export var number_of_enemies: int = 1
@export var enemy_health: int = 100
@export var enemy_speed: float = 50.0
@export var spawn_delay: float = 0.0

# TO be used for other types
# of enemies
@export var enemy_type: String

func _ready() -> void:
	spawn_delay = default_spawn_delay # Sets default delay to 1 second
	enemy_spawn_timer.wait_time = spawn_delay # Configure timer
	
	enemy_spawn_timer.timeout.connect(_on_enemy_spawn_timer_timeout)

# Each wave has more enemies
# And would generally be harder
func start_wave() -> void:	
	# Basically what all we want to do here is
	# To manipulate the variables
	# And then call the timer function again
	wave_changed.emit(number_of_waves, current_number_of_waves)
	
	wave_data_array.clear()
	current_data_index = 0
	enemies_alive_in_wave = 0
	
	
	# Fills it with the amount of enemies
	# we had for each wave
	for i in range(number_of_enemies):
		wave_data_array.append("Enemy")
	
	enemy_spawn_timer.start()
	


func _on_enemy_spawn_timer_timeout() -> void:
	if current_data_index >= wave_data_array.size():
		enemy_spawn_timer.stop()
		spawning_phase_complete.emit()
		return
	
	# Start spawning enemies
	enemy_spawner.spawn_enemy(enemy_health, enemy_speed)
	enemies_alive_in_wave += 1
	current_data_index += 1


func _on_enemy_died():	
	# Payout will be highly dependent on the type of enemy that got killed
	
	# For now, its 50
	GameResource.add_dark_matter(50)
	enemies_alive_in_wave -= 1
	
	if enemies_alive_in_wave == 0:
		_on_wave_cleared()

func _on_wave_cleared() -> void:
	if current_number_of_waves < number_of_waves:
		current_number_of_waves += 1
		print(current_number_of_waves)
		
		enemy_health += 10
		enemy_speed += 10
		number_of_enemies += 1
		
		start_wave()
	else:
		await get_tree().create_timer(2.0).timeout
		
		await get_tree().process_frame
		EventBus.waves_cleared.emit()
	
	

	
