class_name TowerPlacer
extends Node2D

var selected_tower: PackedScene = null

var towers = {
	"archer": preload("res://Scenes/Towers/Archer.tscn"),
	"router": preload("res://Scenes/Towers/Router.tscn"),
	"snowballer": preload("res://Scenes/Towers/snowballer.tscn")
}

func _ready():
	var tower_panel = get_node("..")
	
	for child in tower_panel.get_children():
		if child.has_signal("tower_selected"):
			child.tower_selected.connect(select_tower)
			print("Connected button: ", child.name)
			
func select_tower(tower: String) -> void:
	if tower in towers:
		selected_tower = towers[tower]
		print("Selected: ", tower)
	else:
		print_debug("Tower not found!")
