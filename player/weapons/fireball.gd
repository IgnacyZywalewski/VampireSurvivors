extends Area2D

var level = 1
var hp = 1
var speed = 100
var damage = 10

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animation = $FireballAnimation

signal remove_from_array(object)

func _ready():
	animation.play("fireball")
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	match level:
		1:
			hp = 1
			speed = 100
			damage = 10

func _physics_process(delta):
	position += angle * speed * delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()

func _on_timer_timeout():
	emit_signal("remove_from_array", self)
	queue_free()
