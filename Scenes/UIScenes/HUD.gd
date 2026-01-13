extends CanvasLayer


@onready var dark_matter_label: Label = $Control/GameplayInfo/HBoxContainer/DarkMatter/DarkMatterLabel
@onready var number_constellations_connected_label: Label = $Control/ConstellationDisplay/HBoxContainer/DarkMatter/NumberStarCollected
@onready var number_of_waves: Label = $Control/WaveDisplay/HBoxContainer/DarkMatter/NumberWavesCompleted

func _ready() -> void:
	dark_matter_label.visible = true
	dark_matter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	dark_matter_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	number_constellations_connected_label.visible = true
	number_constellations_connected_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	number_constellations_connected_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	number_of_waves.visible = true
	number_of_waves.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	number_of_waves.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	
	var wave_manager: WaveManager = get_tree().root.find_child("WaveManager", true, false)
	wave_manager.wave_changed.connect(_on_wave_change)
	
	ConstellationManager.constellation_completed.connect(_on_number_constellations_connected_change)
	_on_number_constellations_connected_change()
	
	GameResource.dark_matter_changed.connect(_on_dark_matter_change)
	_on_dark_matter_change(GameResource.dark_matter)

func _on_dark_matter_change(new_amount: int) -> void:
	dark_matter_label.text = str(new_amount) + " DM"

var amount_of_constellations_completed = 0

func _on_number_constellations_connected_change() -> void:
	number_constellations_connected_label.text = str(amount_of_constellations_completed) + "/3"
	amount_of_constellations_completed += 1

func _on_wave_change(wave_num: int) -> void:
	number_of_waves.text = str(wave_num) + "/10"

	
