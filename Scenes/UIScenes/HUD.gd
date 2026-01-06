extends CanvasLayer

@onready var dark_matter_label: Label = $Control/GameplayInfo/HBoxContainer/DarkMatter/DarkMatterLabel

func _ready() -> void:
	dark_matter_label.visible = true
	dark_matter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	dark_matter_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	GameResource.dark_matter_changed.connect(_on_dark_matter_change)
	_on_dark_matter_change(GameResource.dark_matter)

func _on_dark_matter_change(new_amount: int) -> void:
	print("Changed text!")
	dark_matter_label.text = str(new_amount) + " DM"

	
