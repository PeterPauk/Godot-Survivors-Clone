extends Area2D

var speed = 10
var direction = Vector2.ZERO
var damage = 5

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_direction(direction: Vector2):
	self.direction = direction


