extends Node

@export var key_dict: String = ""

#UI scenes to watch out for
@onready var main_menu_scene = Constants.PACKED_SCENE_PATHS.main_menu
@onready var game_scene = Constants.PACKED_SCENE_PATHS.game_scene
@onready var game_over_scene = Constants.PACKED_SCENE_PATHS.game_over

var current_scene: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await change_scene("main_menu")
	
	ConstellationManager.connect("game_is_over", change_scene.bind("game_over_scene"))

func change_scene(key: String) -> void:	
	
	if current_scene:
		current_scene.queue_free()
		await current_scene.tree_exited
	
	match key:
		"main_menu":
			current_scene = main_menu_scene.instantiate()
			add_child(current_scene)
			current_scene.connect("play_pressed",
				func():
					change_scene("game_scene")
			)
		
		"game_scene":
			current_scene = game_scene.instantiate()
			add_child(current_scene)
			
		
		"game_over_scene":
			current_scene = game_over_scene.instantiate()
			add_child(current_scene)
			
			current_scene.retry_pressed.connect(
				func():
					change_scene("game_scene")
			)
