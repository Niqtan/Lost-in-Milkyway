class_name SnowballerTower extends BaseTower

# Define how the archer tower will attack

@onready var sprite: Sprite2D = get_node("Sprite2D")

func _ready():
	# Set the attack cooldown
	attack_cooldown = 2.5

func attack_enemies(target: Enemy) -> void:
	# Change the tower's rotation
	# To make it so that its like 
	# they're attacking the enemies
	
	
	if target:
		# Need to make it so that it doesn't cross 
		# other tiles
		var direction = target.global_position - global_position
		var angle = direction.angle()
		var base_angle = rad_to_deg(angle)
		
		if abs(base_angle) > 90:
			sprite.flip_h = true
			sprite.rotation = deg_to_rad(base_angle - 180 if base_angle > 0 else base_angle + 180)
		else:
			sprite.flip_h = false
			sprite.rotation = angle
