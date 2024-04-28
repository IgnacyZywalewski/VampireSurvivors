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
	global_position = player.global_position
	match level:
		1:
			damage = 0.2
			cooldown_timer = 1
			sprite.scale = Vector2(1.2, 1.2)
			collision_shape.scale = Vector2(1.2, 1.2)
			knockback_amount = 100
		2:
			damage = 0.5
			cooldown_timer = 1
			sprite.scale = Vector2(1.68, 1.68)
			collision_shape.scale = Vector2(1.68, 1.68)
			knockback_amount = 100
		3:
			damage = 0.5
			cooldown_timer = 0.8
			sprite.scale = Vector2(1.68, 1.68)
			collision_shape.scale = Vector2(1.68, 1.68)
			knockback_amount = 150
		4:
			damage = 0.8
			cooldown_timer = 0.8
			sprite.scale = Vector2(1.92, 1.92)
			collision_shape.scale = Vector2(1.92, 1.92)
			knockback_amount = 150
		5:
			damage = 0.8
			cooldown_timer = 0.5
			sprite.scale = Vector2(1.92, 1.92)
			collision_shape.scale = Vector2(1.92, 1.92)
			knockback_amount = 150
		6:
			damage = 1
			cooldown_timer = 0.5
			sprite.scale = Vector2(2.16, 2.16)
			collision_shape.scale = Vector2(2.16, 2.16)
			knockback_amount = 200
		7:
			damage = 1
			cooldown_timer = 0.3
			sprite.scale = Vector2(2.16, 2.16)
			collision_shape.scale = Vector2(2.16, 2.16)
			knockback_amount = 200
		8:
			damage = 2
			cooldown_timer = 0.3
			sprite.scale = Vector2(2.4, 2.4)
			collision_shape.scale = Vector2(2.4, 2.4)
			knockback_amount = 200
