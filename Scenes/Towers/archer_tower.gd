class_name ArcherTower extends BaseTower

# Define how the archer tower will attack

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
var constellation_attack = preload("res://Scenes/Towers/Projectiles/star_attack.tscn")

var target: Enemy = null

func _ready():
	# Set the attack cooldown
	attack_cooldown = 0.8

func attack_enemies(temporary_variable_target: Enemy) -> void:
	# Change the tower's rotation
	# To make it so that its like 
	# they're attacking the enemies
	
	
	if temporary_variable_target:
		# Need to make it so that it doesn't cross 
		# other tiles
		
		target = temporary_variable_target
		if not $AnimatedSprite2D.frame_changed.is_connected(_on_frame_change):
			$AnimatedSprite2D.frame_changed.connect(_on_frame_change)

		$AnimatedSprite2D.play("attack")
		
		$AnimatedSprite2D.flip_h = target.global_position.x < global_position.x


func _on_frame_change():
	var constellation_attack_scene = constellation_attack.instantiate()
	constellation_attack_scene.z_index = 100
	constellation_attack_scene.global_position = $Aim.global_position
	constellation_attack_scene.target = target
		
	if $AnimatedSprite2D.frame == 2:
		get_parent().add_child(constellation_attack_scene)
