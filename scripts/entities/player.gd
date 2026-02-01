extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta)/3
		print(velocity)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	#gets input direction. -1:Left 0:idle 1:right
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		sprite.flip_h=false
	elif direction < 0:
		sprite.flip_h=true
		
	if is_on_floor():
		if direction == 0:
			sprite.play("idle_temp")
		else:
			sprite.play("run")
	else:
		if velocity.y <-25 :
			sprite.play("jump_up")
		elif velocity.y <25 :
			sprite.play("jump_peak")
		else:
			sprite.play("jump_down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
