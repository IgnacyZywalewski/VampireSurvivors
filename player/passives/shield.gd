extends Node2D

var level = 1
var shield_amount = 1

@onready var animation = $AnimationPlayer

func _ready():
	animation.play("shield")
	match level:
		1:
			shield_amount = 1
