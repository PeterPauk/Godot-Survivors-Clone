extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var flashlight = $Light/PointLight2D
@onready var gun_end = $GunEnd

@export var rotation_speed = 25
var bullet =  preload("res://Utility/bullet.tscn").instantiate()
var angle

func _physics_process(delta):
	if angle:
		global_rotation = lerp_angle(global_rotation, angle, delta * rotation_speed)
	print(flashlight.position.y)

func _input(event):
	angle = (get_global_mouse_position()-global_position).angle()
	
	if get_global_mouse_position().x > sprite.global_position.x:
		sprite.flip_v = false;
		flashlight.position.y = 30
	else:
		sprite.flip_v = true;
		flashlight.position.y = 24

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("shoot"):
		shoot()

func shoot():
	add_child(bullet)
	bullet.global_position = gun_end.global_position
	var target = get_global_mouse_position()
	var direction_to_mouse = bullet.global_position.direction_to(target).normalized()
	bullet.set_direction(direction_to_mouse)

		
		
	
		

