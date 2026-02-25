extends Control

@onready var roomr1c1: Button = $MapOverlayCanvas/page1/R1C1
@onready var roomr1c2: Button = $MapOverlayCanvas/page1/R1C2
@onready var roomr1c3: Button = $MapOverlayCanvas/page1/R1C3
@onready var roomr1c4: Button = $MapOverlayCanvas/page2/R1C4
@onready var roomr1c5: Button = $MapOverlayCanvas/page2/R1C5
@onready var roomr2c1: Button = $MapOverlayCanvas/page1/R2C1
@onready var roomr2c2: Button = $MapOverlayCanvas/page1/R2C2
@onready var roomr2c3: Button = $MapOverlayCanvas/page1/R2C3
@onready var roomr2c4: Button = $MapOverlayCanvas/page2/R2C4
@onready var roomr2c5: Button = $MapOverlayCanvas/page2/R2C5
@onready var boss: Button = $MapOverlayCanvas/page3/boss
@onready var left: Button = $MapOverlayCanvas/HBoxContainer/left
@onready var right: Button = $MapOverlayCanvas/HBoxContainer/right
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var map_layout: Node2D = $".."
@onready var world: Node2D = $"../.."

var screen = 1
var enabled = false
var mapData = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
@onready var buttonData = [[roomr1c1,roomr1c2,roomr1c3,roomr1c4,roomr1c5],[roomr2c1,roomr2c2,roomr2c3,roomr2c4,roomr2c5]]

# Called when the node enters the scene tree for the first time.
func _ready():
	print(mapData)
	animation_player.play("RESET")

func mapEditorMode():
	animation_player.play("appear")
	enableButtons()
	$"../../Main".enabled=false
	enabled=true
	left.disabled=true

func exitMapEditor():
	print("exiting")
	animation_player.play("disappear")
	$"../../Main".enabled=true
	enabled=false
	world.startPlayerControl()
	
func enableButtons():
	var check=0
	for row in range(2):
		for col in range (5):
			if mapData[row][col]==0&&row==0&&col==0: buttonData[row][col].disabled=false
			elif mapData[row][col]==0&&row==1&&col==0:
				if mapData[row-1][col]==0: buttonData[row][col].disabled=true
				else: buttonData[row][col].disabled=false
			elif mapData[row][col]==1:
				buttonData[row][col].disabled=true
				check+=1
			elif row==0:
				if mapData[row][col-1]==1 || mapData[row+1][col]==1 :buttonData[row][col].disabled=false
				else: buttonData[row][col].disabled=true
			else:
				if mapData[row][col-1]==1 || mapData[row-1][col]==1: buttonData[row][col].disabled=false
				else:buttonData[row][col].disabled=true
	if check==10: boss.disabled=false
	else: boss.disabled=true

func disableButtons():
	animation_player.play("buttonMouse")

func revertButtons():
	animation_player.play_backwards("buttonMouse")
	
func _on_r_1c_1_pressed() -> void:
	if enabled:
		roomr1c1.disabled = true
		mapData[0][0]=1
		map_layout.getChunk(1,1)
func _on_r_1c_2_pressed() -> void:
	if enabled:
		roomr1c2.disabled = true
		mapData[0][1]=1
		map_layout.getChunk(1,2)
func _on_r_1c_3_pressed() -> void:
	if enabled:
		roomr1c3.disabled = true
		mapData[0][2]=1
		map_layout.getChunk(1,3)
func _on_r_1c_4_pressed() -> void:
	if enabled:
		roomr1c4.disabled = true
		mapData[0][3]=1
		map_layout.getChunk(1,4)
func _on_r_1c_5_pressed() -> void:
	if enabled:
		roomr1c5.disabled = true
		mapData[0][4]=1
		map_layout.getChunk(1,5)
func _on_r_2c_1_pressed() -> void:
	if enabled:
		roomr2c1.disabled = true
		mapData[1][0]=1
		map_layout.getChunk(2,1)
func _on_r_2c_2_pressed() -> void:
	if enabled:
		roomr2c2.disabled = true
		mapData[1][1]=1
		map_layout.getChunk(2,2)
func _on_r_2c_3_pressed() -> void:
	if enabled:
		roomr2c3.disabled = true
		mapData[1][2]=1
		map_layout.getChunk(2,3)
func _on_r_2c_4_pressed() -> void:
	if enabled:
		roomr2c4.disabled = true
		mapData[1][3]=1
		map_layout.getChunk(2,4)
func _on_r_2c_5_pressed() -> void:
	if enabled:
		roomr2c5.disabled = true
		mapData[1][4]=1
		map_layout.getChunk(2,5)
func _on_boss_pressed() -> void:
	if enabled:
		boss.disabled=true
		map_layout.setBoss()
	

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
