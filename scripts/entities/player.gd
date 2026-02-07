extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var lastDirection = null
var rolling = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var scroll: Node2D = $"../scroll"


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta)/2

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	#gets input direction. -1:Left 0:idle 1:right
	var direction := Input.get_axis("move_left", "move_right")
	#if Input.is_action_pressed("leftshift"):
		#rolling = true
	
	if direction > 0:
		sprite.flip_h=false
	elif direction < 0:
		sprite.flip_h=true
	
	if is_on_floor():
		if rolling:
			roll(direction)
		elif direction == 0:
			idle()
		else:
			run(direction)
	else:
		jump(direction)
	if direction:
		lastDirection=direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func roll(direction):
	sprite.play("roll")
	
	velocity
func idle():
	sprite.play("idle_temp")

func run(direction):
	sprite.play("run")

func jump(direction):
	if velocity.y <-25 :
		sprite.play("jump_up")
	elif velocity.y <25 :
		sprite.play("jump_peak")
	else:
		sprite.play("jump_down")
