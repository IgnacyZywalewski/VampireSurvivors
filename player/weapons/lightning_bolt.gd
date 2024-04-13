extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $LightningBoltSprite
@onready var animation = $LightningBoltAnimation
@onready var collision_shape = $CollisionShape2D

var level = 1
var damage = 10
var hurt_box_type = "hit_once"

var target = Vector2.ZERO

func _ready():	
	animation.play("lightning_bolt")
	match level:
		1:
			damage = 10

func _physics_process(_delta):
	if (sprite.frame == 0  or sprite.frame == 7) and collision_shape.disabled == false:
		collision_shape.disabled = true
	elif sprite.frame == 3 and collision_shape.disabled == true:
		collision_shape.disabled = false


func _on_lightning_bolt_animation_animation_finished(_animation):
	queue_free()
