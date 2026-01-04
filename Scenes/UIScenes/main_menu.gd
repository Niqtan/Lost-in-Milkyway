extends CanvasLayer

# Variables to interact with

@onready var exit_button = $Overlay/Container/VBoxContainer/Quit
@onready var play_button = $Overlay/Container/VBoxContainer/Play


signal play_pressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_play_pressed() -> void:
	play_pressed.emit()
	queue_free()
	
func _on_exit_pressed() -> void:
	exit_pressed.emit()
	queue_free()
