# This is the a part of our 1st part of our tower managers
# TOWER UI BEHAVIOR
extends Button

signal tower_selected(tower_type: String)

@export var tower_type: String = ""

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)
		
func _on_button_pressed() -> void:
	tower_selected.emit(tower_type)
