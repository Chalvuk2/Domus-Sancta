extends Node2D

@onready var map_overlay: Control = $MapLayout/MapOverlay
@onready var map_layout: Node2D = $MapLayout
@onready var main: CharacterBody2D = $Main
@onready var main_cam: Camera2D = $Main/MainCam

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_temp_trigger_body_entered(body: Node2D) -> void:
	main_cam.enabled = false
	$MapLayout/cam1.enabled=true
	map_overlay.mapEditorMode()

func startPlayerControl():
	$MapLayout/cam1.enabled=false
	$MapLayout/cam2.enabled=false
	main_cam.enabled = true
