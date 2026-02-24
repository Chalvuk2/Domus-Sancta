extends CharacterBody2D

const SPEED = 100.0
var enabled = true
var rollSpeed = 300.0
const JUMP_VELOCITY = -300.0
var lastDirection = 1.0
var rolling = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var main: CharacterBody2D = $"."

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if enabled:
		if not is_on_floor():
			velocity += (get_gravity() * delta)/2

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor() && !rolling:
			velocity.y = JUMP_VELOCITY


		#gets input direction. -1:Left 0:idle 1:right
		var direction := Input.get_axis("move_left", "move_right")
		if Input.is_action_pressed("leftshift") && is_on_floor():
			rolling = true
		
		if rolling:
			roll(lastDirection)
		
		else:
			if direction > 0:
				sprite.flip_h=false
				$CollisionShape2D.position = Vector2(-2.857,-15.714)
			elif direction < 0:
				sprite.flip_h=true
				$CollisionShape2D.position = Vector2(7.143,-15.714)
			if is_on_floor():
				if rolling:
					roll(lastDirection)
				elif direction == 0:
					idle()
				else:
					run()
			else:
				if !rolling:
					jump()
			if direction:
				lastDirection=direction
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			move_and_slide()
func roll(direction):
	main.set_collision_mask_value(4, false)
	sprite.play("roll")
	velocity.x = direction *rollSpeed
	move_and_slide()
	if rollSpeed > 100:
		rollSpeed-=6.5
	else:
		main.set_collision_mask_value(4, true)
		rolling = false
		rollSpeed=300
func idle():
	sprite.play("idle_temp")

func run():
	sprite.play("run")

func jump():
	if velocity.y <-25 :
		sprite.play("jump_up")
	elif velocity.y <25 :
		sprite.play("jump_peak")
	else:
		sprite.play("jump_down")
