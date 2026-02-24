extends CharacterBody2D

class_name Slime

var hop_speed = 60
var hop_force = -160
var health = 1
var hop_interval = 2.0
var player: Node2D = null
@onready var hop_timer: Timer = $HopTimer
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	hop_timer.wait_time = hop_interval
	hop_timer.timeout.connect(_on_hop_timer_timeout)
	hop_timer.start()
	player = get_tree().get_first_node_in_group("player")
	
func _on_hop_timer_timeout() -> void:
	if is_on_floor() and player:
		var dir = sign(player.global_position.x - global_position.x)
		
		# Hop up + forward toward player
		velocity.y = hop_force
		velocity.x = dir * hop_speed

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Slow down horizontal velocity naturally (friction)
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 10)  # gentle stop  
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			collider.take_damage(1, Vector2(sign(global_position.x - collider.global_position.x) * 150, -100))

func take_damage(dmg: int, knockback: Vector2) -> void:
	health -= dmg
	velocity += knockback
	
	if health <= 0:
		die()

func die() -> void:
	queue_free()

# Damage the player on touch
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1, Vector2(sign(global_position.x - body.global_position.x) * 150, -100))
