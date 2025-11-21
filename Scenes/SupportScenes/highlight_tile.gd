class_name HighlightTile
extends Node2D

func _process(delta: float) -> void:
	var mouse_position: Vector2i = get_global_mouse_position() / 64
	
	position = mouse_position * 64

#BONUS FUNCTION: What if we changed the color 
# of the tile while it is being highlighted?

func set_sprite(texture_scene: PackedScene):
	var scene_instance = texture_scene.instantiate()
	
	var sprite_node = scene_instance.get_node("Sprite2D")
	var texture = sprite_node.texture
	
	$Sprite2D.texture = texture
	
	scene_instance.queue_free()
