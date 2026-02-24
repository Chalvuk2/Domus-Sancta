extends CharacterBody2D

class_name Bat

var speed: float = 90.0          
var bob_amount: float = 8.0      
var bob_speed: float = 4.0       
var health: int = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: float = 1.0                # 1 = right, -1 = left
var start_y: float = 0.0

func _ready() -> void:
	start_y = global_position.y

func _physics_process(delta: float) -> void:
	# Horizontal movement
	velocity.x = direction * speed
	# Flying bob (sine wave)
	velocity.y = sin(Time.get_ticks_msec() / 1000.0 * bob_speed) * bob_amount  
	move_and_slide()
	# Turn around on wall hit
	if is_on_wall():
		direction *= -1
		sprite.flip_h = direction < 0
	# Touch damage to player
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.has_method("take_damage"):
			collider.take_damage(1, Vector2(direction * 120, -80))

func take_damage(dmg: int, knockback: Vector2) -> void:
	health -= dmg
	velocity += knockback
	
	if health <= 0:
		die()

func die() -> void:
	queue_free()
