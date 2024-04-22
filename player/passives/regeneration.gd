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
			regeneration_amount = 1
			cooldown_timer.wait_time = 1


func _on_cooltime_timer_timeout():
	if player.health < player.max_health:
		player.health += regeneration_amount
		player.health_bar.health = player.health
		cooldown_timer.start()
