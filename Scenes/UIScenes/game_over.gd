extends CanvasLayer

# Variables to interact with

@onready var exit_button = $Overlay/Container/VBoxContainer/Quit
@onready var retry_button = $Overlay/Container/VBoxContainer/Retry


# Future main menu button
var main_menu_button


signal retry_pressed
signal main_pressed
signal exit_pressed

func _ready() -> void:
	exit_button.pressed.connect(_on_exit_pressed)
	retry_button.pressed.connect(_on_retry_pressed)

func _on_retry_pressed() -> void:
	retry_pressed.emit()
	
func _on_main_pressed() -> void:
	main_pressed.emit()
	
func _on_exit_pressed() -> void:
	get_tree().quit()
