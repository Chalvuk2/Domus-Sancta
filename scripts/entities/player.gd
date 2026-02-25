extends CharacterBody2D

const SPEED = 100.0
var enabled = true
var rollSpeed = 300.0
const JUMP_VELOCITY = -300.0
var lastDirection = 1.0
var rolling = false
var maxHealth=10
var currentHealth=10
var is_invincible: bool = false
var facing_direction: Vector2 = Vector2.RIGHT
@onready var i_frames_timer: Timer = Timer.new()
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
		
		if Input.is_action_pressed("test"):
			currentHealth-=1
			#what needs to get called whenever health needs to update
			$"../HUD".updateHealth()
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
			if current_weapon:
				current_weapon.scale.x = -1 if sprite.flip_h else 1
				current_weapon.position.x = 25 if not sprite.flip_h else -25
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

func take_damage(dmg: int, knockback: Vector2) -> void:
	if is_invincible: return
	currentHealth -= dmg
	velocity += knockback
	$"../HUD".updateHealth()
	is_invincible = true
	i_frames_timer.start(0.8)
	if currentHealth <= 0:
		queue_free()

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
	add_child(i_frames_timer)
	i_frames_timer.one_shot = true
	i_frames_timer.timeout.connect(func(): is_invincible = false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_weapon:
			current_weapon.attack(facing_direction)


func _on_weapon_attack_finished() -> void: 
	pass 
