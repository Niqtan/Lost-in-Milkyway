extends Button

@export var tower_type: String = ""

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)	
	
func _on_button_pressed() -> void:
	TowerPlacer.select_tower(tower_type)
