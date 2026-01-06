extends Node

# Variables for the tutorial manager:
@onready var hint_manager = $"../HintManager"
@onready var game = get_parent()
@onready var enemy_container = $"../Enemies"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ConstellationManager.star_collected.connect(_on_star_collected)
	enemy_container.child_entered_tree.connect(_on_enemy_spawn)
		
	await get_tree().create_timer(1.0).timeout
	hint_manager.show_label_once("welcome", "Stop the shadows from connecting the stars!")

	
func _on_star_collected():
	hint_manager.show_label_once("first_star", "First star is collected!")

func _on_enemy_spawn(enemy: Enemy):
	if enemy.has_signal("enemy_died"):
		enemy.enemy_died.connect(_on_first_enemy_died)

func _on_first_enemy_died():
	hint_manager.show_label_once("first_dark_matter", "Dark matter forms...")
