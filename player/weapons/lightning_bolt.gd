extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $LightningBoltSprite
@onready var animation = $LightningBoltAnimation
@onready var collision_shape = $CollisionShape2D

var level = 1
var damage = 2
var hurt_box_type = "hit_once"

var target = Vector2.ZERO

func _ready():	
	animation.play("lightning_bolt")
	match level:
		1:
			damage = 2
		2:
			damage = 2
		3:
			damage = 3
			collision_shape.scale = Vector2(1.2, 1.2)
		4:
			damage = 3
		5:
			damage = 3.5
			collision_shape.scale = Vector2(1.6, 1.6)
		6:
			damage = 3.5
		7:
			damage = 4
			collision_shape.scale = Vector2(1.8, 1.8)
		8:
			damage = 4

func _physics_process(_delta):
	if (sprite.frame == 0  or sprite.frame == 7) and collision_shape.disabled == false:
		collision_shape.disabled = true
	elif sprite.frame == 3 and collision_shape.disabled == true:
		collision_shape.disabled = false

func _on_lightning_bolt_animation_animation_finished(_animation):
	queue_free()
