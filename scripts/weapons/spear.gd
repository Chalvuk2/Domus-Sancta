extends Weapon

func _perform_attack() -> void:
	recovery_time = 0.05
	anim.play("stab") 
