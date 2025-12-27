extends CanvasLayer

@onready var hint_label: Label = $HintManager/HintLabel
var hints_shown: Dictionary = {}

func _ready() -> void:
	hint_label.visible = false
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER


func show_label(text_to_show: String, duration: float = 2.5) -> void:
	# Combine showing hint here once and multiple times
	if hint_label.visible:
		return
	
	hint_label.text = text_to_show
	hint_label.modulate.a = 0
	hint_label.visible = true
	
	
	
	
