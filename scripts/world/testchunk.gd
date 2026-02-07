extends Node2D

@onready var playerCamera: Camera2D = $"../Main/Camera2D"
@onready var room_camera: Camera2D = $RoomCamera
@onready var main: CharacterBody2D = $"../Main"


func _on_ready() -> void:
	unlock()

func _LockLeft(body: Node2D) -> void:
	print("locking left")
	lock() # Replace with function body.

func _LockRight(body: Node2D) -> void:
	print("locking right")
	lock() # Replace with function body.

func _UnlockLeft(body: Node2D) -> void:
	print("unlocking left")
	unlock() # Replace with function body.

func _UnlockRight(body: Node2D) -> void:
	print("unlocking right")
	unlock() # Replace with function body.

func lock():
	room_camera.enabled = true
	playerCamera.enabled = false

func unlock():
	playerCamera.enabled = true
	room_camera.enabled = false
	
