extends Control

@onready var roomr1c1: Button = $MapOverlayCanvas/page1/R1C1
@onready var roomr1c2: Button = $MapOverlayCanvas/page1/R1C2
@onready var roomr1c3: Button = $MapOverlayCanvas/page1/R1C3
@onready var roomr1c4: Button = $MapOverlayCanvas/page2/R1C4
@onready var roomr1c5: Button = $MapOverlayCanvas/page2/R1C5
@onready var roomr1c6: Button = $MapOverlayCanvas/page2/R1C6
@onready var roomr2c1: Button = $MapOverlayCanvas/page1/R2C1
@onready var roomr2c2: Button = $MapOverlayCanvas/page1/R2C2
@onready var roomr2c3: Button = $MapOverlayCanvas/page1/R2C3
@onready var roomr2c4: Button = $MapOverlayCanvas/page2/R2C4
@onready var roomr2c5: Button = $MapOverlayCanvas/page2/R2C5
@onready var roomr2c6: Button = $MapOverlayCanvas/page2/R2C6
@onready var left: Button = $MapOverlayCanvas/HBoxContainer/left
@onready var right: Button = $MapOverlayCanvas/HBoxContainer/right
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var map_layout: Node2D = $".."
@onready var world: Node2D = $"../.."

var screen = 1
var enabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("RESET")

func mapEditorMode():
	animation_player.play("appear")
	enabled=true 
	left.disabled=true
func exitMapEditor():
	animation_player.play("RESET")
	enabled=false
	world.startPlayerControl()
	


func _on_r_1c_1_pressed() -> void:
	if enabled:
		roomr1c1.disabled = true
		map_layout.setChunk(1,1)
func _on_r_1c_2_pressed() -> void:
	if enabled:
		roomr1c2.disabled = true
		map_layout.setChunk(1,2)
func _on_r_1c_3_pressed() -> void:
	if enabled:
		roomr1c3.disabled = true
		map_layout.setChunk(1,3)
func _on_r_1c_4_pressed() -> void:
	if enabled:
		roomr1c4.disabled = true
		map_layout.setChunk(1,4)
func _on_r_1c_5_pressed() -> void:
	if enabled:
		roomr1c5.disabled = true
		map_layout.setChunk(1,5)
func _on_r_1c_6_pressed() -> void:
	if enabled:
		roomr1c6.disabled = true
		map_layout.setChunk(1,6)
func _on_r_2c_1_pressed() -> void:
	if enabled:
		roomr2c1.disabled = true
		map_layout.setChunk(2,1)
func _on_r_2c_2_pressed() -> void:
	if enabled:
		roomr2c2.disabled = true
		map_layout.setChunk(2,2)
func _on_r_2c_3_pressed() -> void:
	if enabled:
		roomr2c3.disabled = true
		map_layout.setChunk(2,3)
func _on_r_2c_4_pressed() -> void:
	if enabled:
		roomr2c4.disabled = true
		map_layout.setChunk(2,4)
func _on_r_2c_5_pressed() -> void:
	if enabled:
		roomr2c5.disabled = true
		map_layout.setChunk(2,5)
func _on_r_2c_6_pressed() -> void:
	if enabled:
		roomr2c6.disabled = true
		map_layout.setChunk(2,6)

func _page_left() -> void:
	if enabled:
		$".."/cam2.enabled=false
		$".."/cam1.enabled=true
		animation_player.play("screen left")
		left.disabled = true
		right.disabled = false
func _page_right() -> void:
	if enabled:
		$".."/cam1.enabled=false
		$".."/cam2.enabled=true
		animation_player.play_backwards("screen right")
		right.disabled=true
		left.disabled=false
		
