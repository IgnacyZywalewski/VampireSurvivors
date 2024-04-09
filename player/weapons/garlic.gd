extends Area2D

var level = 1
var damage = 1
var hurt_box_type = "cooldown"
var cooldown_timer = 1

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $GarlicSprite
@onready var garlic_animation = $GarlicAnimation

func _ready():
	garlic_animation.play("attack")
	match level:
		1:
			damage = 2
			cooldown_timer = 1


func _physics_process(delta):
	position = player.global_position * delta
