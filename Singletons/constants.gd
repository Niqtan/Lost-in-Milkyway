extends Node
# You can put here constants
# of scene paths so that you don't have to
# deal with every single script
# using the constant
	
const SCENE_PATHS: Dictionary = {
	"lightning_attack": "uid://dgser2dvmea1u",
	"star_scene": "uid://bxjpn78hxx1w",
	"game_over": "uid://dj8030jbe5auy"
}

const PACKED_SCENE_PATHS := { 
	"main_menu": preload("uid://dwqd1seu14t74"),
	"game_scene": preload("uid://cmg6aoovnep43"),
	"game_over": preload("uid://dj8030jbe5auy"),
	"game_won": preload("uid://2ue7o2q0h55u")
}
