extends Node2D


@onready var area_2d: Area2D = $Area2D
@onready var scroll: Node2D = $scroll


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	scroll.visible = true
	print("YAHG")
