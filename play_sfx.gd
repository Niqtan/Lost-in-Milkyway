extends Node

@onready var player := AudioStreamPlayer.new()
@onready var player_track_2 := AudioStreamPlayer.new()
@onready var player_track_3 := AudioStreamPlayer.new()


var sfx = {
	"first_star": preload("uid://c58uf1jth5ilc"),
	"dark_matter": preload("uid://c6u6v2nk6h3e7"),
	"laser": preload("uid://b3lsgoexojicu"),
	"vanish": preload("uid://cscx1inpo5m4o"),
	"defeat": preload("uid://yr83ryx5ntyo"),
	"win": preload("uid://vxdbxbjloimy")
}

var played_once_sfx = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(player)
	add_child(player_track_2)
	add_child(player_track_3)
	AudioBus.play_sfx.connect(_on_play_sfx)


func _on_play_sfx(name: String, once: bool):
	
	if once and played_once_sfx.get(name, false):
		return
	
	if name == "laser":
		player_track_2.stream = sfx["laser"]
		player_track_2.play()
	elif name == "vanish":
		player_track_3.stream = sfx["vanish"]
		player_track_3.play()
	else:
		player.stream = sfx[name]
		player.play()
		
	if once: 
		played_once_sfx[name] = true
