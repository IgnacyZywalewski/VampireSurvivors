extends CharacterBody2D

@export var movement_speed = 30.0
@export var hp = 10
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")  
@onready var sprite = $BatSprite
@onready var animation = $BatFlyAnimation
@onready var hit_flash_animation = $HitFlashAnimation

signal remove_from_array(object)

func _ready():
	animation.play("fly")

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true

func _on_hurtbox_hurt(damage, angle, knockback_amount):
	hp -= damage
	hit_flash_animation.play("hit_flash")
	
	if angle == Vector2.ZERO:
		if position.x < player.position.x and position.y < player.position.y:
			angle = Vector2(-1,-1)
		if position.x < player.position.x and position.y > player.position.y:
			angle = Vector2(-1,1)
		if position.x > player.position.x and position.y < player.position.y:
			angle = Vector2(1,-1)
		if position.x > player.position.x and position.y > player.position.y:
			angle = Vector2(1,1)
	knockback = angle * knockback_amount
	
	if hp <= 0:
		emit_signal("remove_from_array", self)
		queue_free()
