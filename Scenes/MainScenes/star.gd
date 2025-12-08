class_name Star
extends Node2D


"""
This script manages how the star
will behave.

Since the goal of the enemy is to
complete the constellation by connecting stars,
then we'll need 3 parts to this:
	
1. To generate the stars & constellations
2. To define the relationship of the enemy to those stars
3. To define the consequence of the relationship

"""

var grid_position: Vector2i
var is_occupied: bool = false
var occupying_enemy: Enemy = null

@onready var sprite = $StarSprite
@onready var particles = $Glow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid_position = Vector2i(global_position / 64)

func occupy(enemy: Enemy) -> void:
	if not is_occupied:
		is_occupied = true
		occupying_enemy = enemy
 
func vacate() -> void:
	is_occupied = false
	occupying_enemy = null
	
func highlight() -> void:
	pass
	
func unhighlight() -> void:
	pass
