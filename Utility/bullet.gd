extends Area2D

class_name Bullet
var speed = 30
var move_dir: Vector2 = Vector2.ZERO
var damage

func _process(delta):
	global_position += move_dir * delta * speed


	
