extends Area2D

var sprite_blue = preload("res://assets/textures/items/blue_gem.png")
var sprite_red = preload("res://assets/textures/items/red_gem.png")
var sprite_gold = preload("res://assets/textures/items/gold_gem.png")

var target = null
var speed = -1
var enemy_difficulty = -1
var experience = 1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected

func _ready():
	match enemy_difficulty:
		0: #easy
			sprite.texture = sprite_blue
			sprite.scale = Vector2(0.1, 0.1)
			experience = 1
		1: #medium 
			sprite.texture = sprite_red
			experience = 6
			sprite.scale = Vector2(0.1, 0.1)
		2: #hard
			sprite.texture = sprite_gold
			experience = 15
			sprite.scale = Vector2(0.1, 0.1)

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 7 * delta

func collect():
	sound.play()
	collision.call_deferred("set", "disabled", true)
	sprite.visible = false
	collision.visible = false
	return experience

func _on_snd_collected_finished():
	queue_free()
