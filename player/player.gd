extends CharacterBody2D

var movement_speed = 40.0
var hp = 100


@onready var animation = $Animation
@onready var idle_sprite = $Animation/IdleSprite
@onready var walk_sprite = $Animation/WalkSprite
@onready var collision_shape = $CollisionShape2D

#Weapons
var fireball = preload("res://player/weapons/fireball.tscn")
var shooting_star = preload("res://player/weapons/shooting_star.tscn")
var black_hole = preload("res://player/weapons/black_hole.tscn")
var lightning_bolt = preload("res://player/weapons/lightning_bolt.tscn")


#Weapons nodes
@onready var fireball_timer = get_node("%FireballTimer")
@onready var fireball_attack_timer = get_node("%FireballAttackTimer")
@onready var shooting_star_timer = get_node("%ShootingStarTimer")
@onready var shooting_star_attack_timer = get_node("%ShootingStarAttackTimer")
@onready var lightning_bolt_timer = get_node("%LightningBoltTimer")
@onready var lightning_bolt_attack_timer = get_node("%LightningBoltAttackTimer")

#Fireball
var fireball_ammo = 0
var fireball_baseammo = 1
var fireball_level = 0

#Shooting star
var shooting_star_ammo = 0
var shooting_star_baseammo = 1
var shooting_star_level = 0

#BlackHole
var black_hole_level = 1
var black_hole_attack = null

#LightningBolt
var lightning_bolt_ammo = 0
var lightning_bolt_baseammo = 1
var lightning_bolt_level = 0

#Enemy
var enemy_close = []

func _ready():
	attack()

func attack():
	if fireball_level > 0 and fireball_timer.is_stopped():
		fireball_timer.start()
			
	if shooting_star_level > 0 and shooting_star_timer.is_stopped():
		shooting_star_timer.start()
		
	if black_hole_level > 0 and black_hole_attack == null:
		black_hole_attack = black_hole.instantiate()
		black_hole_attack.level = black_hole_level
		add_child(black_hole_attack)
		
	if lightning_bolt_level > 0 and lightning_bolt_timer.is_stopped():
		lightning_bolt_timer.start()

func _physics_process(delta):
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov.x < 0:
		walk_sprite.flip_h = true
		idle_sprite.flip_h = true
		
	elif mov.x > 0:
		walk_sprite.flip_h = false
		idle_sprite.flip_h = false
		
	if mov != Vector2.ZERO:
		idle_sprite.visible = false
		walk_sprite.visible = true
		animation.play("walk")
	else:
		idle_sprite.visible = true
		walk_sprite.visible = false
		animation.play("idle")
		
	walk_sprite.global_position = global_position
	idle_sprite.global_position = global_position
	collision_shape.global_position = global_position
	velocity = mov.normalized() * movement_speed
	move_and_slide()

func _on_hurtbox_hurt(damage, _angle, _knockback):
	hp -= damage
	print(hp)


func _on_fireball_timer_timeout():
	fireball_ammo += fireball_baseammo
	fireball_attack_timer.start()

func _on_fireball_attack_timer_timeout():
	if fireball_ammo > 0:
		var fireball_attack = fireball.instantiate()
		fireball_attack.position = position
		fireball_attack.target = get_nearest_target()
		fireball_attack.level = fireball_level
		add_child(fireball_attack)
		fireball_ammo -= 1
		if fireball_ammo > 0:
			fireball_attack_timer.start()
		else:
			fireball_attack_timer.stop()


func _on_shooting_star_timer_timeout():
	shooting_star_ammo += shooting_star_baseammo
	shooting_star_attack_timer.start()

func _on_shooting_star_attack_timer_timeout():
	if shooting_star_ammo > 0:
		var shooting_star_attack = shooting_star.instantiate()
		shooting_star_attack.position = position
		shooting_star_attack.target = get_random_target()
		shooting_star_attack.level = shooting_star_level
		add_child(shooting_star_attack)
		shooting_star_ammo -= 1
		if shooting_star_ammo > 0:
			shooting_star_attack_timer.start()
		else:
			shooting_star_attack_timer.stop()


func _on_lightning_bolt_timer_timeout():
	lightning_bolt_ammo += lightning_bolt_baseammo
	lightning_bolt_attack_timer.start()

func _on_lightning_bolt_attack_timer_timeout():
	if lightning_bolt_ammo > 0:
		var lightning_bolt_attack = lightning_bolt.instantiate()
		lightning_bolt_attack.target = get_random_target()
		lightning_bolt_attack.position = lightning_bolt_attack.target
		lightning_bolt_attack.level = lightning_bolt_level
		add_child(lightning_bolt_attack)
		lightning_bolt_ammo -= 1
		if lightning_bolt_ammo > 0:
			lightning_bolt_attack_timer.start()
		else:
			lightning_bolt_attack_timer.stop()


func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().position
	else:
		return Vector2.UP 

func get_nearest_target():
	var nearest_distance = INF
	var nearest_enemy = null
	
	if enemy_close.size() > 0:
		for enemy in enemy_close:
			var distance = position.distance_to(enemy.global_position)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_enemy = enemy.global_position
			return nearest_enemy
	else:
		return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
