extends Control

# Variables to interact with

@onready var exit_button = $Container/VBoxContainer/Quit



signal exit_pressed

func _ready() -> void:
	exit_button.pressed.connect(_on_exit_pressed)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$CPUParticles2D.emitting = !$CPUParticles2D.emitting
		
func _on_exit_pressed() -> void:
	get_tree().quit()
