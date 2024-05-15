extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0
signal changetime(time)

var bat = preload("res://enemy/enemy_bat.tscn")
var hound = preload("res://enemy/enemy_hound.tscn")
var mummy = preload("res://enemy/enemy_mummy.tscn")
var revenant = preload("res://enemy/enemy_revenant.tscn")

func _ready():
	connect("changetime", Callable(player, "change_time"))

func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns
	for i in enemy_spawns:
		if time >= i.time_start and time <= i.time_end:
			if i.spawn_delay_counter < i.enemy_spawn_delay:
				i.spawn_delay_counter += 1
			else:
				i.spawn_delay_counter = 0
				var new_enemy = i.enemy
				var counter = 0
				while counter < i.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1
	emit_signal("changetime", time)

func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.2)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_side = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	
	return Vector2(x_spawn, y_spawn)


var spawns = [
	#1 minute
	{	#Bat 0-20
		time_start = 0,
		time_end = 20,
		enemy = bat,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	{	#Bat 20-40
		time_start = 20,
		time_end = 40,
		enemy = bat,
		enemy_num = 2,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	{	#Bat 40-60
		time_start = 40,
		time_end = 60,
		enemy = bat,
		enemy_num = 3,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	
	#2 minute
	{	#Hound 60-80
		time_start = 60,
		time_end = 80,
		enemy = hound,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	{	#Hound 80-100
		time_start = 80,
		time_end = 100,
		enemy = hound,
		enemy_num = 2,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	{	#Hound 100-120
		time_start = 100,
		time_end = 120,
		enemy = hound,
		enemy_num = 3,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	{	#Bat 100-120
		time_start = 100,
		time_end = 120,
		enemy = bat,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	}
]
