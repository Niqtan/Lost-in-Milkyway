class_name HighlightTile
extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2i = get_global_mouse_position() / 64
	
	position = mouse_position * 64
