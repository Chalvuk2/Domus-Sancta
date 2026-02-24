extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var facing_direction: Vector2 = Vector2.RIGHT
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
	
	if current_weapon:
		if sprite.flip_h:
			current_weapon.scale.x = -1          # face left
			current_weapon.position.x = -20 
		else:
			current_weapon.scale.x = 1           # face right
			current_weapon.position.x = 25

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

# Weapon Logic
@export var sword_scene: PackedScene
@export var spear_scene: PackedScene
@export var hammer_scene: PackedScene

var current_weapon: Weapon
var unlocked_weapons = [true, false, false]

func equip_weapon(slot: int) -> void:
	if current_weapon:
		current_weapon.queue_free()
		current_weapon = null
	var new_weapon: Weapon = null
	match slot:
		0: 
			if sword_scene: 
				new_weapon = sword_scene.instantiate()
		1: 
			if spear_scene: 
				new_weapon = spear_scene.instantiate()
		2: 
			if hammer_scene: 
				new_weapon = hammer_scene.instantiate()
	if new_weapon:
		add_child(new_weapon)
		new_weapon.position = Vector2(20, 0)
		current_weapon = new_weapon

func _ready() -> void:
	equip_weapon(0)  # start with sword

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_weapon:
			current_weapon.attack(facing_direction)
	if event.is_action_pressed("weapon_1"): equip_weapon(0)
	if event.is_action_pressed("weapon_2") and unlocked_weapons[1]: equip_weapon(1)
	if event.is_action_pressed("weapon_3") and unlocked_weapons[2]: equip_weapon(2)

func _on_weapon_attack_finished() -> void: 
	pass 
