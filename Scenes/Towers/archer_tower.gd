class_name ArcherTower extends BaseTower

# Define how the archer tower will attack

@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
var constellation_attack = preload("res://Scenes/Towers/Projectiles/star_attack.tscn")

var target: Enemy = null

func _ready():
	# Set the attack cooldown
	super._ready()
	attack_cooldown = 2.5
	attack_timer.wait_time = attack_cooldown
	
func attack_enemies(temporary_variable_target: Enemy) -> void:
	# Change the tower's rotation
	# To make it so that its like 
	# they're attacking the enemies
	print("Attack called!")
	if temporary_variable_target:
		# Need to make it so that it doesn't cross 
		# other tiles
		
		target = temporary_variable_target
		
		if target:
			if not $AnimatedSprite2D.frame_changed.is_connected(_on_frame_change):
				$AnimatedSprite2D.frame_changed.connect(_on_frame_change)

			$AnimatedSprite2D.play("attack")
			$AnimatedSprite2D.flip_h = target.global_position.x < global_position.x
			
			await $AnimatedSprite2D.animation_looped
			
			if $AnimatedSprite2D.frame_changed.is_connected(_on_frame_change):
				$AnimatedSprite2D.frame_changed.disconnect(_on_frame_change)
			
			$AnimatedSprite2D.play("idle")

func on_target_lost() -> void:
	#Disconnect the signal
	if $AnimatedSprite2D.frame_changed.is_connected(_on_frame_change):
		$AnimatedSprite2D.frame_changed.disconnect(_on_frame_change)
	
	target = null
	
	if $AnimatedSprite2D.animation != "idle":
		$AnimatedSprite2D.play("idle")
	
func _on_frame_change():
	if target:
		if $AnimatedSprite2D.frame == 2:
			var constellation_attack_scene = constellation_attack.instantiate()
			constellation_attack_scene.z_index = 100
			constellation_attack_scene.global_position = $Aim.global_position
			constellation_attack_scene.target = target
			
			get_parent().add_child(constellation_attack_scene)
			
			
