extends CanvasLayer

# Variables to interact with

@onready var exit_button = $Overlay/MarginContainer/ExitGame
@onready var main_menu_button = $Overlay/MarginContainer/MainMenu
@onready var retry_button = $Overlay/MarginContainer/Retry


signal retry_pressed
signal main_pressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_pressed.connect(_on_main_pressed)
	exit_pressed.connect(_on_exit_pressed)
	retry_pressed.connect(_on_retry_pressed)

func _on_retry_pressed() -> void:
	retry_pressed.emit()
	queue_free()
	
func _on_main_pressed() -> void:
	main_pressed.emit()
	queue_free()
	
func _on_exit_pressed() -> void:
	exit_pressed.emit()
	queue_free()
