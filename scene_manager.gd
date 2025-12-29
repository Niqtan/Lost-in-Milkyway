extends Node

@export var key_dict: String = ""

#UI scenes to watch out for
@onready var main_menu_scene = get_node("res://Scenes/UIScenes/main_menu.tscn")
@onready var game_scene = get_node("res://Scenes/MainScenes/scene_handler.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_scene(key_dict)
	game_scene.connect("play_pressed", go_to_game_scene)

func change_scene(key: String) -> void:
	get_tree().change_scene_to_packed(Constants.PACKED_SCENE_PATHS[key])


func go_to_main_menu() -> void:
	change_scene("main_menu")

func go_to_game_scene() -> void:
	change_scene("game_scene")
