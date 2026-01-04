extends Node

@export var key_dict: String = ""

#UI scenes to watch out for
@onready var main_menu_scene = Constants.PACKED_SCENE_PATHS.main_menu
@onready var game_scene = Constants.PACKED_SCENE_PATHS.game_scene
@onready var game_over_scene = Constants.PACKED_SCENE_PATHS.game_over

var main_menu_instance
var game_scene_instance
var game_over_scene_instance

var scenes: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_instance = main_menu_scene.instantiate()
	game_scene_instance = game_scene.instantiate()
	game_over_scene_instance = game_over_scene.instantiate()
	
	add_child(main_menu_instance)
	add_child(game_scene_instance)
	add_child(game_over_scene_instance)
	
	scenes["main_menu"] = main_menu_instance
	scenes["game_scene"] = game_scene_instance
	scenes["game_over_scene"] = game_over_scene_instance
	
	main_menu_instance.connect("play_pressed", change_scene.bind("game_scene"))
	ConstellationManager.connect("game_is_over", change_scene.bind("game_over_scene"))
	game_over_scene_instance.connect("retry_pressed", change_scene.bind("game_scene"))

	change_scene(key_dict)

func change_scene(key: String) -> void:	
	
	main_menu_instance.visible = false
	game_over_scene_instance.visible = false
	
	for scene in scenes.values():
		scene.process_mode = Node.PROCESS_MODE_DISABLED
		
	if scenes.has(key):
		if key == "main_menu":
			scenes[key].visible = true
		elif key == "game_scene":
			if game_scene_instance.is_inside_tree():
				game_scene_instance.queue_free()
				game_scene_instance = game_scene.instantiate()
				
				add_child(game_scene_instance)
				scenes["game_instance"] = game_scene_instance
		elif key == "game_over_scene":
			scenes[key].visible = true
			
		scenes[key].process_mode = Node.PROCESS_MODE_INHERIT

			
