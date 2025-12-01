class_name ArcherTower extends BaseTower

# Define how the archer tower will attack

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
var constellation_attack = preload("res://Scenes/Towers/Projectiles/star_attack.tscn")


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
		var constellation_attack_scene = constellation_attack.instantiate()
		
		get_parent().add_child(constellation_attack_scene)
		constellation_attack_scene.z_index = 100
		constellation_attack_scene.global_position = $Aim.global_position
		constellation_attack_scene.target = target
		
		self.look_at(target.global_position)
