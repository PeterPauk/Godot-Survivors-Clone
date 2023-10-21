extends Area2D

@export_enum("Cooldown", "HitOnce", "DisableHitBox") var hurt_box_type = 0

@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

signal hurt(damage)


func _on_area_entered(area):
	if area.is_in_group("attack"):
		#semka pojde attack animacia
		if not area.get("damage") == null:
			match hurt_box_type:
				0:
					collision.call_deferred("set", "disabled", true)
					disable_timer.start()
				1:
					pass
				2:
					if area.has_method("tempdisable"):
						area.tempdisable()	
						
			var damage = area.damage
			emit_signal("hurt", damage)
					
				
func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
