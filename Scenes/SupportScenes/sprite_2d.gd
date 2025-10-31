"""
# I think what's going to separate
this from the wave manager is just
one simple sentence,

"I know where and how to spawn" 
"""

class_name EnemySpawner
extends Sprite2D


@export var wave_data_array: Array = [ ]
#Allow the default_spawn_delay to be editable
@export var default_spawn_delay: float = 1.0
