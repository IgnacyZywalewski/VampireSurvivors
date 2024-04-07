extends Area2D

var level = 1
var bounce_num = 5
var speed = 150
var damage = 5

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

@onready var sprite = $ShootingStar
@onready var shooting_star_animation = $ShootingStarAnimation

func _ready():
	shooting_star_animation.play("shooting_star")
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(-90)
	match level:
		1:
			bounce_num = 5
			speed = 150
			damage = 5

func _physics_process(delta):
	position += speed * delta * angle
	var vpr = get_viewport_rect().size 
	
	if position.x - sprite.texture.get_height()/8 < player.global_position.x - vpr.x/2 or position.x + sprite.texture.get_height()/8> player.global_position.x + vpr.x/2:
		angle.x *= -1
		bounce_num -= 1
		rotation = deg_to_rad(360) - rotation
		
	if position.y < player.global_position.y - vpr.y/2 or position.y > player.global_position.y + vpr.y/2:
		angle.y *= -1
		bounce_num -= 1
		rotation = deg_to_rad(180) - rotation

	if bounce_num <= 0:
		queue_free()
