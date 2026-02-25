extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")

func summon():
	$AnimationPlayer.play("blur")

func _on_button_pressed() -> void:
	$AnimationPlayer.play_backwards("blur")
