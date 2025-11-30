class_name ArcherTower extends BaseTower

# Define how the archer tower will attack

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")


func _ready():
	# Set the attack cooldown
	attack_cooldown = 0.8

func attack_enemies(target: Enemy) -> void:
	# Change the tower's rotation
	# To make it so that its like 
	# they're attacking the enemies
	
	
	if target:
		# Need to make it so that it doesn't cross 
		# other tiles
		animated_sprite.play("attack")
		var direction = target.global_position - global_position
		var angle = direction.angle()
		var base_angle = rad_to_deg(angle)
		
		if abs(base_angle) > 90:
			animated_sprite.flip_h = true
			animated_sprite.rotation = deg_to_rad(base_angle - 180 if base_angle > 0 else base_angle + 180)
		else:
			animated_sprite.flip_h = false
			animated_sprite.rotation = angle
	else:
		animated_sprite.play("idle")
