extends CharacterBody2D

@export var movement_speed = 30.0
@export var hp = 10
@export var knockback_recovery = 3.5
@export_enum("easy", "medium", "hard") var enemy_difficulty = 0
var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")  
@onready var sprite = $BatSprite
@onready var animation = $BatFlyAnimation
@onready var hit_flash_animation = $HitFlashAnimation
@onready var loot_base = get_tree().get_first_node_in_group("loot")  

var exp_gem = preload("res://objects/experience_gem.tscn")

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
	hit_flash_animation.play("hit_flash")
	
	hp -= damage
	angle = -global_position.direction_to(player.global_position)
	knockback = angle * knockback_amount
	
	if hp <= 0:
		death()

func death():
	var new_gem = exp_gem.instantiate()
	new_gem.enemy_difficulty = enemy_difficulty
	new_gem.position = global_position
	loot_base.call_deferred("add_child", new_gem)
	emit_signal("remove_from_array", self)
	queue_free()
