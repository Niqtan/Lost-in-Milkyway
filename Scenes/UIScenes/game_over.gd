extends CanvasLayer

# Variables to interact with

@onready var exit_button = $Overlay/MarginContainer/ExitGame
@onready var main_menu_button = $Overlay/MarginContainer/MainMenu
@onready var retry_button = 


signal retry_pressed
signal main_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_scene()

func _process(delta: float) -> void:
	

func game_over_scene() -> void:
	# Update the current scene with the game ove scene
