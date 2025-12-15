class_name Star
extends Node2D


"""
This is 3/3 of the constellation
series of scripts

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
@onready var particles = $StarSprite/Glow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	grid_position = Vector2(global_position / 64)
	
func _on_body_entered(body):
	if body is Enemy:
		body.occupy_star(self)

func occupy(enemy: Enemy) -> void:
	if not is_occupied:
		is_occupied = true
		occupying_enemy = enemy
		highlight()
		ConstellationManager.star_occupied(self)
 
func vacate() -> void:
	is_occupied = false
	occupying_enemy = null
	unhighlight()
	ConstellationManager.star_vacated(self)
	
func highlight() -> void:
	# Use the GPUParticles2D Node
	# To highlight the stars
	
	particles.visible = true
	particles.energy = 1.5
	particles.color = Color(1, 1, 0.5)	
	
func unhighlight() -> void:
	particles.enabled = false
