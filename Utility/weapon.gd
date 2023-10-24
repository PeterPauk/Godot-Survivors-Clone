extends CharacterBody2D

@onready var sprite = $Sprite2D

@export var rotation_speed = 25
var angle

func _physics_process(delta):
	if angle:
		global_rotation = lerp_angle(global_rotation, angle, delta * rotation_speed)

func _input(event):
	angle = (get_global_mouse_position()-global_position).angle()
	#gun flipping based on mouse position
	if get_global_mouse_position().x > sprite.global_position.x:
		sprite.flip_v = false;	
	else:
		sprite.flip_v = true;
	
		

