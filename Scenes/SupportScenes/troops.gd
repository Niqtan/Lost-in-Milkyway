class_name TowerPlacer
extends Node2D

var selected_tower: PackedScene = null

var towers = {
	"archer": preload("res://Scenes/Towers/Archer.tscn"),
	"router": preload("res://Scenes/Towers/Router.tscn"),
	"snowballer": preload("res://Scenes/Towers/snowballer.tscn")
}

func select_tower(tower: String) -> void:
	if tower in towers:
		selected_tower = towers[tower]
		print("Selected: ", tower)
	else:
		print_debug("Tower not found!")
