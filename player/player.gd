extends CharacterBody2D

var movement_speed = 80.0
@export var basic_movement_speed = 80
@export var health = 100
@export var max_health = 100
var dead = false

var experience = 0
var experience_level = 1
var collected_experience = 0

var time = 0

var level = "res://world/world.tscn"

#Player
@onready var animation_tree = $Animation
@onready var hit_flash_animation = $HitFlashAnimation
@onready var idle_sprite = $Animation/IdleSprite
@onready var walk_sprite = $Animation/WalkSprite
@onready var death_sprite = $Animation/DeathSprite
@onready var collision_shape = $CollisionShape2D

@onready var grab_area_collision = $GrabArea/CollisionShape2D

#Gui
@onready var experience_bar = get_node("%ExperienceBar")
@onready var level_label = get_node("%LevelLabel")
@onready var time_label = get_node("%TimerLabel")
@onready var health_bar = $HealthBar
@onready var result_label = get_node("%ResultLabel")
@onready var death_panel = get_node("%DeathPanel")
@onready var level_up_panel = get_node("%LevelUpPanel")
@onready var upgrade_options = get_node("%UpgradeOptions")
@onready var item_option = preload("res://ui/item_option.tscn")
@onready var pause_screen = get_node("%PauseScreen")
@onready var collected_weapons = get_node("%CollectedWeapons")
@onready var collected_passives = get_node("%CollectedPassives")
@onready var item_container = preload("res://ui/item_container.tscn")

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
var fireball_baseammo = 0
var fireball_level = 0

#ShootingStar
var shooting_star_ammo = 0
var shooting_star_baseammo = 0
var shooting_star_level = 0

#BlackHole
var black_hole_level = 0
var black_hole_attack = null

#LightningBolt
var lightning_bolt_ammo = 0
var lightning_bolt_baseammo = 0
var lightning_bolt_level = 0

#Passives
var shield = preload("res://player/passives/shield.tscn")
var shield_level = 0
var shield_amount = 0
var shield_passive = null

var regeneration = preload("res://player/passives/regeneration.tscn")
var regeneration_level = 0
var regeneration_amount = 0
var regeneration_passive = null

#Enemy
var enemy_close = []

#Upgrades
var collected_upgrades = []
var upgrade_options_available = []
var additional_attacks = 0


func _ready():
	upgrade_charackter("fireball_1")
	attack()
	set_experience_bar(experience, callculate_experience_cap())
	health_bar.init_health(health)

func attack():
	if fireball_level > 0 and fireball_timer.is_stopped():
		fireball_timer.start()
			
	if shooting_star_level > 0 and shooting_star_timer.is_stopped():
		shooting_star_timer.start()
		
	if lightning_bolt_level > 0 and lightning_bolt_timer.is_stopped():
		lightning_bolt_timer.start()
	
	if black_hole_level > 0:
		if black_hole_attack != null:
			black_hole_attack.queue_free()
		black_hole_attack = black_hole.instantiate()
		black_hole_attack.level = black_hole_level
		add_child(black_hole_attack)
	
	if shield_level > 0:
		if shield_passive != null:
			shield_passive.queue_free()
		shield_passive = shield.instantiate()
		shield_passive.level = shield_level
		add_child(shield_passive)
		
	if regeneration_level > 0:
		if regeneration_passive != null:
			regeneration_passive.queue_free()
		regeneration_passive = regeneration.instantiate()
		regeneration_passive.level = regeneration_level
		add_child(regeneration_passive)

func _physics_process(_delta):
	if dead == false:
		movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	
	if mov.x < 0:
		walk_sprite.flip_h = true
		idle_sprite.flip_h = true
		death_sprite.flip_h = true
		
	elif mov.x > 0:
		walk_sprite.flip_h = false
		idle_sprite.flip_h = false
		death_sprite.flip_h = false
		
	if mov != Vector2.ZERO:
		idle_sprite.visible = false
		walk_sprite.visible = true
		animation_tree.play("walk")
	else:
		idle_sprite.visible = true
		walk_sprite.visible = false
		animation_tree.play("idle")
		
	walk_sprite.global_position = global_position
	idle_sprite.global_position = global_position
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()

func _on_hurtbox_hurt(damage, _angle, _knockback):
	health -= clamp(damage - shield_amount, 1.0, 999.0)
	health_bar.health = health
	print(health)
	hit_flash_animation.play("hit_flash")
	if health <= 0:
		dead = true
		death()

func death():
	walk_sprite.visible = false
	idle_sprite.visible = false
	death_sprite.visible = true
	death_sprite.position = idle_sprite.global_position
	animation_tree.play("death")

func _on_animation_animation_finished(anim_name):
	if anim_name == "death":
		get_tree().paused = true
		death_panel.visible = true
		
		var tween = death_panel.create_tween()
		tween.tween_property(death_panel, "position", Vector2(220, 65), 2.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
		tween.play()


func _on_fireball_timer_timeout():
	fireball_ammo += fireball_baseammo + additional_attacks
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
	shooting_star_ammo += shooting_star_baseammo + additional_attacks
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
	lightning_bolt_ammo += lightning_bolt_baseammo + additional_attacks
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
		level_up()
		callculate_experience(0)
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


func get_random_item():
	var database_list = []
	for i in UpgradeDataBase.UPGRADES:
		if i in collected_upgrades:
			pass
		elif i in upgrade_options_available:
			pass
		elif UpgradeDataBase.UPGRADES[i]["type"] == "item":
			pass
		elif UpgradeDataBase.UPGRADES[i]["prerequesits"].size() > 0:
			var to_add = true
			for j in UpgradeDataBase.UPGRADES[i]["prerequesits"]:
				if not j in collected_upgrades:
					to_add = false
			if to_add:
				database_list.append(i)
		else :
			database_list.append(i)
			
	if database_list.size() > 0:
		var random_item = database_list.pick_random()
		upgrade_options_available.append(random_item)
		return random_item
	else:
		return null

func adjust_ui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDataBase.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDataBase.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDataBase.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = item_container.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collected_weapons.add_child(new_item)
				"passive":
					collected_passives.add_child(new_item)

func level_up():
	level_label.text = str("Level: ", experience_level)
	level_up_panel.visible = true
	
	var tween = level_up_panel.create_tween()
	tween.tween_property(level_up_panel, "position", Vector2(220, 65), 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
	var options = 0
	var options_max = 3
	while options < options_max:
		var options_choice = item_option.instantiate()
		options_choice.item = get_random_item()
		upgrade_options.add_child(options_choice)
		options += 1 
	get_tree().paused = true

func upgrade_charackter(upgrade):
	match upgrade:
		"fireball_1":
			fireball_level = 1
			fireball_baseammo += 1
		"fireball_2":
			fireball_level = 2
			fireball_baseammo += 1
		"fireball_3":
			fireball_level = 3
		"fireball_4":
			fireball_level = 4
			fireball_baseammo += 1
		"fireball_5":
			fireball_level = 5
		"fireball_6":
			fireball_level = 6
			fireball_baseammo += 1
		"fireball_7":
			fireball_level = 7
		"fireball_8":
			fireball_level = 8
			
		"black_hole_1":
			black_hole_level = 1
		"black_hole_2":
			black_hole_level = 2
		"black_hole_3":
			black_hole_level = 3
		"black_hole_4":
			black_hole_level = 4
		"black_hole_5":
			black_hole_level = 5
		"black_hole_6":
			black_hole_level = 6
		"black_hole_7":
			black_hole_level = 7
		"black_hole_8":
			black_hole_level = 8
			
		"shooting_star_1":
			shooting_star_level = 1
			shooting_star_baseammo += 1
		"shooting_star_2":
			shooting_star_level = 2	
		"shooting_star_3":
			shooting_star_level = 3
		"shooting_star_4":
			shooting_star_level = 4
			shooting_star_baseammo += 1
		"shooting_star_5":
			shooting_star_level = 5
		"shooting_star_6":
			shooting_star_level = 6
		"shooting_star_7":
			shooting_star_level = 7
			shooting_star_baseammo += 1
		"shooting_star_8":
			shooting_star_level = 8
			
		"lightning_bolt_1":
			lightning_bolt_level = 1
			lightning_bolt_baseammo += 1
		"lightning_bolt_2":
			lightning_bolt_level = 2
			lightning_bolt_baseammo += 1
		"lightning_bolt_3":
			lightning_bolt_level = 3
		"lightning_bolt_4":
			lightning_bolt_level = 4
		"lightning_bolt_5":
			lightning_bolt_level = 5
			lightning_bolt_baseammo += 1
		"lightning_bolt_6":
			lightning_bolt_level = 6
			lightning_bolt_baseammo += 1
		"lightning_bolt_7":
			lightning_bolt_level = 7
			lightning_bolt_baseammo += 1
		"lightning_bolt_8":
			lightning_bolt_level = 8
			lightning_bolt_baseammo += 1
		
		"shield_1":
			shield_level = 1
		"shield_2":
			shield_level = 2
		"shield_3":
			shield_level = 3
		"shield_4":
			shield_level = 4
		"shield_5":
			shield_level = 5
		
		"regeneration_1":
			regeneration_level = 1
		"regeneration_2":
			regeneration_level = 2
		"regeneration_3":
			regeneration_level = 3
		"regeneration_4":
			regeneration_level = 4
		"regeneration_5":
			regeneration_level = 5
			
		"wings_1","wings_2","wings_3","wings_4","wings_5":
			movement_speed += 0.1 * basic_movement_speed
			
		"ring_1","ring_2":
			additional_attacks += 1
			
		"magnet_1":
			grab_area_collision.shape.radius = 30.0
		"magnet_2","magnet_3","magnet_4":
			grab_area_collision.shape.radius += 10
		"magnet_5":
			grab_area_collision.shape.radius += 20
		
		"food":
			health += 10
			health = clamp(health, 0, max_health)

	adjust_ui_collection(upgrade)
	collected_upgrades.append(upgrade)
	attack()

func level_up_panel_hide():
	var option_children = upgrade_options.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options_available.clear()
	
	var tween = level_up_panel.create_tween()
	tween.tween_property(level_up_panel, "position", Vector2(220, 380), 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	await tween.finished
	
	level_up_panel.visible = false
	get_tree().paused = false
	callculate_experience(0)

func upgrade_process(upgrade):
	upgrade_charackter(upgrade)
	level_up_panel_hide()


func change_time(argtime = 0):
	time = argtime
	var get_s = time % 60
	var get_m = int(time/60)
	if get_s < 10:
		get_s = str(0, get_s)
	if get_m < 10:
		get_m = str(0, get_m)
	time_label.text = str(get_m, ":", get_s)


func _on_replay_button_click_end():
	dead = false
	get_tree().paused = false
	get_tree().change_scene_to_file(level)

func _on_menu_button_click_end():
	dead = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/menu.tscn")

func _on_exit_button_click_end():
	get_tree().quit()

func _on_pause_button_pressed():
	get_tree().paused = true
	pause_screen.visible = true
