extends CharacterBody2D

var movement_speed = 60.0
var hp = 80

var can_dash = true
@onready var sprite = $Sprite2D
@onready var walk_timer = get_node("%WalkTimer")
@onready var enemy = get_tree().get_first_node_in_group("enemy")
@onready var walk_anim = $AnimationPlayer

var shadow_orb_attack =  preload("res://Cards/shadow_orb_card.tscn")

func _ready():
	var shadow = shadow_orb_attack.instantiate()
	add_child(shadow)
	shadow.attack()

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
	


