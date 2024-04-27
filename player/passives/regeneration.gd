extends Node2D

@onready var animation = $AnimationPlayer
@onready var cooldown_timer = $CooltimeTimer
@onready var player = get_tree().get_first_node_in_group("player")

var level = 1
var regeneration_amount = 0

func _ready():
	animation.play("regeneration")
	match level:
		1:
			global_position = player.global_position
			regeneration_amount = 0.1
			cooldown_timer.wait_time = 1
		2:
			regeneration_amount = 0.2
			cooldown_timer.wait_time = 0.9
		3:
			regeneration_amount = 0.3
			cooldown_timer.wait_time = 0.8
		4:
			regeneration_amount = 0.4
			cooldown_timer.wait_time = 0.7
		5:
			regeneration_amount = 0.5
			cooldown_timer.wait_time = 0.6


func _on_cooltime_timer_timeout():
	if player.health < player.max_health:
		player.health += regeneration_amount
		player.health_bar.health = player.health
		cooldown_timer.start()
