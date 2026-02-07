extends Node2D

@onready var positioner: CanvasLayer = $positioner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	desummon()

func summon():
	print("daniel mentioned")
	positioner.visible=true
	
func desummon():
	positioner.visible=false
