extends Weapon

func _perform_attack() -> void:
	damage = 2 # Hits harder...    
	knockback = 300.0
	recovery_time = 0.3 # ...and slower
	anim.play("smash")   
