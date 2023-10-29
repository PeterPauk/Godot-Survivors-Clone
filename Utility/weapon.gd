extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var flashlight = $Light/PointLight2D

@export var rotation_speed = 25
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
		
		
	
		

