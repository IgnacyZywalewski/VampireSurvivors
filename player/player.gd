extends CharacterBody2D

@export var movement_speed = 80.0
@export var health = 100

var experience = 0
var experience_level = 1
var collected_experience = 0

var time = 0

@onready var animation = $Animation
@onready var hit_flash_animation = $HitFlashAnimation
@onready var idle_sprite = $Animation/IdleSprite
@onready var walk_sprite = $Animation/WalkSprite
@onready var death_sprite = $Animation/DeathSprite
@onready var collision_shape = $CollisionShape2D
@onready var experience_bar = get_node("%ExperienceBar")
@onready var level_label = get_node("%LevelLabel")
@onready var time_label = get_node("%TimerLabel")
@onready var health_bar = $HealthBar

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
var fireball_level = 1

#Shooting starssssssssssss
var shooting_star_ammo = 0
var shooting_star_baseammo = 1
var shooting_star_level = 1

#BlackHole
var black_hole_level = 1

#LightningBolt
var lightning_bolt_ammo = 0
var lightning_bolt_baseammo = 1
var lightning_bolt_level = 1

#Enemy
var enemy_close = []

func _ready():
	attack()
	set_experience_bar(experience, callculate_experience_cap())
	health_bar.init_health(health)

func attack():
	if fireball_level > 0 and fireball_timer.is_stopped():
		fireball_timer.start()
			
	if shooting_star_level > 0 and shooting_star_timer.is_stopped():
		shooting_star_timer.start()
		
	if black_hole_level > 0:
		var black_hole_attack = black_hole.instantiate()
		black_hole_attack.level = black_hole_level
		black_hole_attack.global_position = global_position
		add_child(black_hole_attack)
		
	if lightning_bolt_level > 0 and lightning_bolt_timer.is_stopped():
		lightning_bolt_timer.start()

func _physics_process(_delta):
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
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()

func _on_hurtbox_hurt(damage, _angle, _knockback):
	health -= damage
	health_bar.health = health
	print(health)
	hit_flash_animation.play("hit_flash")
	#if health <= 0:
		#walk_sprite.visible = false
		#idle_sprite.visible = false
		#death_sprite.visible = true
		#animation.play("death")


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


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect() 
		callculate_experience(gem_exp)

func callculate_experience(gem_experience):
	var experience_required = callculate_experience_cap()
	collected_experience += gem_experience
	if experience + collected_experience >= experience_required:
		collected_experience -= experience_required - experience
		experience_level += 1
		experience = 0
		experience_required = callculate_experience_cap()
		callculate_experience(0)
		level_label.text = str("Level: ", experience_level)
	else:
		experience += collected_experience
		collected_experience = 0
	
	set_experience_bar(experience, experience_required)

func callculate_experience_cap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level * 5
	elif experience_level < 40:
		exp_cap = 95 + (experience_level - 19) * 8
	else:
		exp_cap = 255 + (experience_level-39) * 12
	return exp_cap

func set_experience_bar(set_value = 1, set_max_value = 100):
	experience_bar.value = set_value
	experience_bar.max_value = set_max_value

func change_time(argtime = 0):
	time = argtime
	var get_s = time % 60
	var get_m = int(time/60)
	if get_s < 10:
		get_s = str(0, get_s)
	if get_m < 10:
		get_m = str(0, get_m)
	time_label.text = str(get_m, ":", get_s)
