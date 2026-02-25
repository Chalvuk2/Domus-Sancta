extends Control

@onready var main: CharacterBody2D = $"../Main"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateHealth()

func updateHealth():
	$CanvasLayer/TextureProgressBar.value = main.currentHealth*100 / main.maxHealth
	print($CanvasLayer/TextureProgressBar.value)


func _on_pause_pressed() -> void:
	$"../Pause".testPause()
