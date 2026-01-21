class_name HighlightTile
extends Node2D

@onready var tilemap = $"../Foreground"


func _process(delta: float) -> void:
	var mouse_position: Vector2i = get_global_mouse_position() / 64
	
	position = mouse_position * 64

#BONUS FUNCTION: What if we changed the color 
# of the tile while it is being highlighted?

func set_sprite(texture_scene: PackedScene):
	var scene_instance = texture_scene.instantiate()
	
	var sprite_node = scene_instance.get_node("AnimatedSprite2D")
	
	$AnimatedSprite2D.offset = Vector2(32, 32)
	$AnimatedSprite2D.sprite_frames = sprite_node.sprite_frames
	$AnimatedSprite2D.play("idle")
	
	sprite_node.offset = Vector2(32, 32)
	
	scene_instance.queue_free()
