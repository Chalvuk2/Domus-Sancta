extends Node2D

var mapData = []
var grid_width = 2
var grid_height = 3
const ROOM_1_TEMP = preload("uid://fbkypssd6kr3")
@onready var placed_rooms: Node2D = $PlacedRooms
@onready var map_overlay: Control = $MapOverlay

func _ready():
	for i in grid_width:
		mapData.append([])
		for j in grid_height:
			mapData[i].append(0) # Set a starter value for each position
	print(mapData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setChunk(row,col):
	var x= 5
	var y = 337
	var roomCreate = ROOM_1_TEMP.instantiate()
	placed_rooms.add_child(roomCreate)
	roomCreate.global_position = Vector2(((col-1)*380)+x,((row-1)*213)+y)
	map_overlay.exitMapEditor()
