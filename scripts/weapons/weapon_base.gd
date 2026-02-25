class_name Weapon
extends Node2D

@export var damage: int = 1
@export var recovery_time: float = 0.1 
@export var knockback: float = 200.0
@export var attack_duration: float = 0.4

var can_attack: bool = true
var is_attacking: bool = false

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var cooldown_timer: Timer = Timer.new()

func _ready() -> void:
	add_child(cooldown_timer)
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(_on_cooldown_timeout)
	hitbox.body_entered.connect(_on_hit)
	hitbox.monitoring = false 
	if hitbox.get_child_count() > 0:
		hitbox.get_child(0).visible = false

# Call this from Player script on attack input
func attack(direction: Vector2) -> void:
	if not can_attack or is_attacking: return   
	is_attacking = true
	can_attack = false   
	anim.play("attack")
	hitbox.monitoring = true
	if hitbox.get_child_count() > 0:
		hitbox.get_child(0).visible = true
	await get_tree().create_timer(attack_duration).timeout
	
	hitbox.monitoring = false
	if hitbox.get_child_count() > 0:
		hitbox.get_child(0).visible = false
	is_attacking = false
	cooldown_timer.start(recovery_time)

func _on_attack_started() -> void:
	pass

func _on_hit(body: Node2D) -> void:
	if body == get_parent(): return
	if body.has_method("take_damage"):
		var kb_dir = (body.global_position - global_position).normalized()
		body.take_damage(damage, kb_dir * knockback)

func _on_cooldown_timeout() -> void:
	can_attack = true
