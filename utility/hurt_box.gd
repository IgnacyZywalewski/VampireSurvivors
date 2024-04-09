extends Area2D

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)

var hit_once_array = []

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == null:
			match area.get("hurt_box_type"):
				"cooldown": #Cooldown
					disable_timer.set_wait_time(area.get("cooldown_timer"))
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				"hit_once": #HitOnce
					if hit_once_array.has(area) == false:
						hit_once_array.append(area)
						if area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array", Callable(self, "remove_from_list")):
								area.connect("remove_from_array", Callable(self, "remove_from_list"))
					else:
						return 
				#"disable_hit_box": #DisableHitBox
					#if area.has_method("tempdisable"):
						#area.tempdisable()
			var damage = area.damage
			emit_signal("hurt", damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func remove_from_list(object):
	if hit_once_array.has(object):
		hit_once_array.erase(object)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
