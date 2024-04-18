extends Area2D

@export var damage = 2
@onready var collision = $CollisionShape2D

var hurt_box_type = "cooldown"
@export var cooldown_timer = 1
