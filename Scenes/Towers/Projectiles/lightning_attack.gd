extends Node2D

var target: Enemy = null
var constellation_damage: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Constellation atatck set to: ", target)

	$AnimatedSprite2D.play("strike")
	if target and is_instance_valid(target):
		self.look_at(target.global_position)
		target.take_damage(constellation_damage)
		
	await $AnimatedSprite2D.animation_finished
	queue_free()
