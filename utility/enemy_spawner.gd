extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0
signal changetime(time)

var bat = preload("res://enemy/enemy_bat.tscn")
var hound = preload("res://enemy/enemy_hound.tscn")
var mummy = preload("res://enemy/enemy_mummy.tscn")
var revenant = preload("res://enemy/enemy_revenant.tscn")
var drake = preload("res://enemy/enemy_poison_drake.tscn")
var skull = preload("res://enemy/enemy_warp_skull.tscn")
var fire_elemental = preload("res://enemy/enemy_fire_elemental.tscn")
var solar = preload("res://enemy/enemy_solar.tscn")
var death = preload("res://enemy/enemy_death.tscn")

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
		enemy_num = 5,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	
	#2 minute
	{	#Hound 60-80
		time_start = 60,
		time_end = 80,
		enemy = hound,
		enemy_num = 3,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	{	#Hound 80-100
		time_start = 80,
		time_end = 100,
		enemy = hound,
		enemy_num = 5,
		enemy_spawn_delay = 4,
		spawn_delay_counter = 0
	},
	{	#Hound 105-120
		time_start = 105,
		time_end = 120,
		enemy = hound,
		enemy_num = 8,
		enemy_spawn_delay = 5,
		spawn_delay_counter = 0
	},
	{	#Bat 100-120
		time_start = 80,
		time_end = 120,
		enemy = bat,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	
	#3 minute
	{	#mummy 120-160
		time_start = 120,
		time_end = 160,
		enemy = mummy,
		enemy_num = 3,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	{	#bat 160-180
		time_start = 160,
		time_end = 180,
		enemy = bat,
		enemy_num = 2,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	
	#4 minute
	{	#bat 180-240
		time_start = 180,
		time_end = 240,
		enemy = bat,
		enemy_num = 20,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	
	
	#5 minute
	{	#drake 240-300
		time_start = 240,
		time_end = 340,
		enemy = drake,
		enemy_num = 3,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	#6 minute
	{	#revenant 300-360
		time_start = 300,
		time_end = 400,
		enemy = revenant,
		enemy_num = 3,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	 #7 minute
	{	#skull 300-360
		time_start = 360,
		time_end = 420,
		enemy = skull,
		enemy_num = 3,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	
	
	{	#bat 320-400
		time_start = 320,
		time_end = 400,
		enemy = bat,
		enemy_num = 5,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	
	#8 minute
	{	#fire_elemental 420-450
		time_start = 420,
		time_end = 450,
		enemy = fire_elemental,
		enemy_num = 1,
		enemy_spawn_delay = 2,
		spawn_delay_counter = 0
	},
	{	#fire_elemental 450-480
		time_start = 450,
		time_end = 480,
		enemy = fire_elemental,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	
	#9 minute
	{	#solar 420-480
		time_start = 480,
		time_end = 540,
		enemy = solar,
		enemy_num = 3,
		enemy_spawn_delay = 5,
		spawn_delay_counter = 0
	},
	
	#10 minute
	{	#solar 540-600
		time_start = 540,
		time_end = 600,
		enemy = solar,
		enemy_num = 3,
		enemy_spawn_delay = 5,
		spawn_delay_counter = 0
	},
	{	#fire_elemental 540-600
		time_start = 540,
		time_end = 600,
		enemy = fire_elemental,
		enemy_num = 3,
		enemy_spawn_delay = 3,
		spawn_delay_counter = 0
	},
	{	#drake 540-600
		time_start = 540,
		time_end = 600,
		enemy = drake,
		enemy_num = 2,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	{	#skull 540-600
		time_start = 540,
		time_end = 600,
		enemy = skull,
		enemy_num = 3,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	{	#revenant 540-600
		time_start = 540,
		time_end = 600,
		enemy = revenant,
		enemy_num = 5,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	{	#mummy 540-600
		time_start = 540,
		time_end = 600,
		enemy = mummy,
		enemy_num = 5,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	{	#hound 540-600
		time_start = 540,
		time_end = 600,
		enemy = hound,
		enemy_num = 5,
		enemy_spawn_delay = 1,
		spawn_delay_counter = 0
	},
	{	#bat 540-600
		time_start = 540,
		time_end = 600,
		enemy = bat,
		enemy_num = 5,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	},
	
	#10 minute
	{	#death
		time_start = 600,
		time_end = 601,
		enemy = death,
		enemy_num = 1,
		enemy_spawn_delay = 0,
		spawn_delay_counter = 0
	}
]
