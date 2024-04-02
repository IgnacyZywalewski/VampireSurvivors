extends CharacterBody2D

var movement_speed = 40.0
var hp = 100
@onready var sprite = $Sprite2D
@onready var walk_timer = get_node("WalkTimer")

#Weapons
var fireball = preload("res://player/weapons/fireball.tscn")

#Weapons nodes
@onready var fireball_timer = get_node("%FireballTimer")
@onready var fireball_attack_timer = get_node("%FireballAttackTimer")

#Fireball
var fireball_ammo = 0
var fireball_baseammo = 1
var fireball_attakcspeed = 1.5
var fireball_level = 1

#Enemy
var enemy_close = []

func _ready():
	attack()

func attack():
	if fireball_level > 0:
		fireball_timer.wait_time = fireball_attakcspeed
		if fireball_timer.is_stopped():
			fireball_timer.start()

func _physics_process(_delta):
	movement()

func movement():
	
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false
	
	if mov != Vector2.ZERO:
		if walk_timer.is_stopped():
			if sprite.frame >= sprite.hframes -1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walk_timer.start()
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()

func _on_hurtbox_hurt(damage):
	hp -= damage
	print(hp)

func _on_fireball_timer_timeout():
	fireball_ammo += fireball_baseammo
	fireball_attack_timer.start()

func _on_fireball_attack_timer_timeout():
	if fireball_ammo > 0:
		var fireball_attack = fireball.instantiate()
		fireball_attack.position = position
		fireball_attack.target = get_random_target()
		fireball_attack.level = fireball_level
		add_child(fireball_attack)
		fireball_ammo -= 1
		if fireball_ammo > 0:
			fireball_attack_timer.start()
		else:
			fireball_attack_timer.stop()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP 

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
