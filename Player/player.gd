extends CharacterBody2D

var movement_speed = 60.0
var hp = 80

#attacks
var shadowOrb = preload("res://Abilities/shadow_orb.tscn")

#attack nodes
@onready var shadowOrbTimer = get_node("%ShadowOrbTimer")
@onready var shadowOrbAttackTimer = get_node("%ShadowAttackTimer")

#shadow orb
var shadow_orb_ammo = 0
var shadow_baseammo = 1
var shadow_atkspeed = 4
var shadow_level = 1

#enemy related
var enemy_close = []



var can_dash = true
@onready var sprite = $Sprite2D
@onready var walk_timer = get_node("%WalkTimer")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@onready var walk_anim = $AnimationPlayer

func _ready():
	attack()

func _physics_process(delta):
	movement()
	
	#dash 
	if Input.is_action_just_pressed("dash") and can_dash == true:
		dash()
		dash_cooldown()
		
	#walking animation
	if Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		walk_anim.play("walk")
	else:
		walk_anim.stop()
		
func attack():
	if shadow_level > 0:
		shadowOrbTimer.wait_time = shadow_atkspeed
		if shadowOrbTimer.is_stopped():
			shadowOrbTimer.start()
		
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)

	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
	if get_global_mouse_position().x > sprite.global_position.x:
		sprite.flip_h = false;
		
	else:
		sprite.flip_h = true;

func dash():
	movement_speed = 300
	$Timer.start()
	
func dash_cooldown():
	can_dash = false
	$Dash_Cooldown.start()
	
func _on_timer_timeout():
	movement_speed = 60
func _on_dash_cooldown_timeout():
	can_dash = true


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
	

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

