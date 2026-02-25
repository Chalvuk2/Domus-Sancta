extends Control

#used to call Animation player, the node used to fade the screen in and out
@onready var room_1: TextureButton = $CanvasLayer/PanelContainer/HBoxContainer/Room1
@onready var room_2: TextureButton = $CanvasLayer/PanelContainer/HBoxContainer/Room2
@onready var room_3: TextureButton = $CanvasLayer/PanelContainer/HBoxContainer/Room3
@onready var room_4: TextureButton = $CanvasLayer/PanelContainer/HBoxContainer/Room4
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var roomData = [false,false,false,false]

var enabled = false
#_ready playes whenever the game starts, making the menu disappear
func _ready():
	animation_player.play("RESET")

#resume is used to unpause the game back to its normal state
func closeRoomPicker():
	animation_player.play("buttonDisappear")
	disableMouse()
	animation_player.play_backwards("blur")
	enabled = false
	
#pause is used to freeze the game then pull up menu
func openRoomPicker():
	animation_player.play("buttonDisappear")
	enableRooms()
	$"../MapOverlay".disableButtons()
	animation_player.play("blur")
	enabled = true 

func disableMouse():
	$CanvasLayer/ColorRect.mouse_filter=Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/PanelContainer.mouse_filter=Control.MOUSE_FILTER_IGNORE
	$CanvasLayer/PanelContainer/HBoxContainer.mouse_filter=Control.MOUSE_FILTER_IGNORE
	room_1.mouse_filter=Control.MOUSE_FILTER_IGNORE
	room_2.mouse_filter=Control.MOUSE_FILTER_IGNORE
	room_3.mouse_filter=Control.MOUSE_FILTER_IGNORE
	room_4.mouse_filter=Control.MOUSE_FILTER_IGNORE
	
func enableRooms():
	clearButton()
	var count=0
	while count!=3:
		printt("stuck",count)
		var randRoom = randi_range(1,4)
		match randRoom:
			1:
				if !room_1.visible:
					count+=1
					room_1.visible=true
					room_1.disabled=false
					room_1.mouse_filter=Control.MOUSE_FILTER_STOP
			2:
				if !room_2.visible:
					count+=1
					room_2.visible=true
					room_2.disabled=false
					room_2.mouse_filter=Control.MOUSE_FILTER_STOP
			3:
				if !room_3.visible:
					count+=1
					room_3.visible=true
					room_3.disabled=false
					room_3.mouse_filter=Control.MOUSE_FILTER_STOP
			4:
				if !room_4.visible:
					count+=1
					room_4.visible=true
					room_4.disabled=false
					room_4.mouse_filter=Control.MOUSE_FILTER_STOP
			_:
				print("hit")

			
func clearButton():
	room_1.visible=false
	room_1.disabled=false
	room_2.visible=false
	room_2.disabled=false
	room_3.visible=false
	room_3.disabled=false
	room_4.visible=false
	room_4.disabled=false


func _on_room_1_pressed() -> void:
	if enabled:
		$"..".setRoom(1)
		roomData[0]=true
		closeRoomPicker()


func _on_room_2_pressed() -> void:
	if enabled:
		$"..".setRoom(2)
		roomData[1]=true
		closeRoomPicker()


func _on_room_3_pressed() -> void:
	if enabled:
		$"..".setRoom(3)
		roomData[2]=true
		closeRoomPicker()

func _on_room_4_pressed() -> void:
	if enabled:
		$"..".setRoom(4)
		roomData[3]=true
		closeRoomPicker()
