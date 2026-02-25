extends Node2D

@onready var map_overlay: Control = $MapLayout/MapOverlay
@onready var map_layout: Node2D = $MapLayout
@onready var main: CharacterBody2D = $Main
@onready var main_cam: Camera2D = $Main/MainCam
var walls = []
var floors=[]
var amount=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for row in range(2):
		var row_array = []
		
		for col in range(5):
			var path = "wallBoundries/wallStop " + str(row+1) + "_" + str(col+1) + "/CollisionShape2D2"
			var shape_node = get_node(path)
			row_array.append(shape_node)
		walls.append(row_array)
	print(walls)
	for col in range(6):
		var path = "floorBoundries/floorStop 1_" + str(col + 1)+ "/CollisionShape2D"
		var node = get_node(path)
		floors.append(node)

	print(floors)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_temp_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		main_cam.enabled = false
		$MapLayout/cam1.enabled=true
		map_overlay.mapEditorMode()

func startPlayerControl():
	$MapLayout/cam1.enabled=false
	$MapLayout/cam2.enabled=false
	main_cam.enabled = true
	disableWalls()

func disableWalls():
	var mapData=$MapLayout/MapOverlay.getMapData()
	for row in range(mapData.size()):
		for col in range(mapData[row].size()):
			match row:
				0:
					match col:
						0,1,2,3,4:
							if mapData[0][col]==1&&mapData[0][col+1]==1:
								walls[0][col].disabled=true
								amount+=1
								print("i live")
							if mapData[0][col]==1&&mapData[1][col]==1:
								floors[col].disabled=true
						_:
							print("this shouldn't be hit")
				1:
					match col:
						0,1,2,3,4:
							if mapData[1][col]==1&&mapData[1][col+1]==1:
								walls[1][col].disabled=true
				
				_:
					print("sad")
	if amount==10:
		$"wallBoundries/wallStop boss/CollisionShape2D2".disabled=true
