extends Node2D

var target: Enemy = null
var constellation_damage: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	if not target or not is_instance_valid(target):
		queue_free()
		return
	
	self.look_at(target.global_position)
	self.rotation -= deg_to_rad(90)
	
	var distance = global_position.distance_to(target.global_position)
	var sprite_height = 64
	var scale_factor = distance / sprite_height
	$AnimatedSprite2D.scale.y = scale_factor
	
	target.take_damage(constellation_damage)
	
	AudioBus.play_sfx.emit("laser", false)
	$AnimatedSprite2D.play("strike")
	
	await $AnimatedSprite2D.animation_looped
	queue_free()
