extends Node2D

var level = 1
var shield_amount = 0

@onready var animation = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	animation.play("shield")
	match level:
		1:
			global_position = player.global_position
			shield_amount = 1
		2:
			shield_amount = 1.5
		3:
			shield_amount = 2
		4:
			shield_amount = 2.5
		5:
			shield_amount = 3
