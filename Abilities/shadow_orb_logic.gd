extends Node2D

#attacks
var shadowOrb = preload("res://Abilities/shadow_orb.tscn")

@onready var shadowOrbTimer = get_node("%ShadowOrbTimer")
@onready var shadowOrbAttackTimer = get_node("%ShadowAttackTimer")
@onready var player = get_tree().get_first_node_in_group("player")


#shadow orb
var shadow_orb_ammo = 0
var shadow_baseammo = 1
var shadow_atkspeed = 4
var shadow_level = 1

#enemy related
var enemy_close = []

func _process(delta):
		position = player.position


func attack():
	if shadow_level > 0:
		shadowOrbTimer.wait_time = shadow_atkspeed
		if shadowOrbTimer.is_stopped():
			shadowOrbTimer.start()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_shadow_attack_timer_timeout():
	if shadow_orb_ammo > 0:
		var shadow_attack = shadowOrb.instantiate()
		shadow_attack.position = position
		shadow_attack.target = get_random_target()
		shadow_attack.level = shadow_level
		add_child(shadow_attack)
		shadow_orb_ammo -= 1
		if shadow_orb_ammo > 0:
			shadowOrbAttackTimer.start()
		else:
			shadowOrbAttackTimer.stop()

func _on_shadow_orb_timer_timeout():
	shadow_orb_ammo += shadow_baseammo
	shadowOrbAttackTimer.start()

func _on_enemy_detect_area_body_entered(body:Node2D):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detect_area_body_exited(body:Node2D):
	if enemy_close.has(body):
		enemy_close.erase(body)
