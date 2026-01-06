# This is the 1st part of our tower managers
# TOWER IDENTIFICATION
class_name TowerPlacer
extends Node2D

var selected_tower: PackedScene = null
var tower_cost: int = 0

var towers = {
	# Change this part
	"archer": {
		
	"scene": preload("res://Scenes/Towers/Archer.tscn"),
	"cost": 50,
	},
	"router": preload("res://Scenes/Towers/Router.tscn"),
	"snowballer": preload("res://Scenes/Towers/snowballer.tscn")
}

func _ready():
	var tower_panel = get_node("..")
	print("Parent node: ", tower_panel.name)
	print("Parent's children: ")
	search_and_connect(tower_panel)

# Use a recursion algorithm to search for the 
# Buttons
func search_and_connect(node: Node):
	for child in node.get_children():
		print("  - ", child.name, "(type: ", child.get_class(), ")")
		if child != self and child.has_signal("tower_selected"):
			child.tower_selected.connect(select_tower)
			print("Connected button: ", child.name)
		search_and_connect(child)
	
func select_tower(tower: String) -> void:
	if tower in towers:
		selected_tower = towers[tower]["scene"]
		tower_cost = towers[tower]["cost"]
		print(selected_tower.get_class())
		print("Selected: ", tower)
	else:
		print_debug("Tower not found!")
