extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $BlackHoleSprite
@onready var animation = $BlackHoleAnimation
@onready var collision_shape = $CollisionShape2D

var level = 1
var damage = 1
var hurt_box_type = "cooldown"
var cooldown_timer = 2
var knockback_amount = 100

var angle = Vector2.ZERO

func _ready():
	animation.play("black_hole")
	match level:
		1:
			damage = 2
			cooldown_timer = 1
			sprite.scale = Vector2(2,2)
			collision_shape.scale = Vector2(2,2)
			knockback_amount = 100
