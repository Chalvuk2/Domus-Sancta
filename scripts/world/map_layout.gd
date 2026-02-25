extends Node2D


@onready var placed_rooms: Node2D = $PlacedRooms
@onready var map_overlay: Control = $MapOverlay
var lastRow
var lastCol

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getChunk(row,col):
	lastRow=row
	lastCol=col
	$RoomPicker.openRoomPicker()

func setBoss():
	var roomCreate = preload("uid://cyoav2f42xc5r").instantiate()
	placed_rooms.add_child(roomCreate)
	roomCreate.global_position = Vector2(1904,550)
	map_overlay.exitMapEditor()

func setRoom(roomNum):
	var roomCreate = load(getUid(roomNum)).instantiate()
	var x= 5
	var y = 337
	placed_rooms.add_child(roomCreate)
	roomCreate.global_position = Vector2(((lastCol-1)*380)+x,((lastRow-1)*213)+y)
	map_overlay.exitMapEditor()

func getUid(roomNum):
	var uidReturn
	if lastRow==1:
		match roomNum:
			1:
				uidReturn = "uid://fbkypssd6kr3"
			2:
				uidReturn = "uid://cmd8c4111w311"
			3:
				uidReturn = "uid://b6ft5enustja3"
			4:
				uidReturn = "uid://dp5xoieoidghl"
	else:
		match roomNum:
			1:
				uidReturn = "uid://c12q5nbsdtndx"
			2:
				uidReturn = "uid://bgc6082unr7su"
			3:
				uidReturn = "uid://dm58slb8sd6fn"
			4:
				uidReturn = "uid://dhid42or5rp25"
			
	return uidReturn
			
			
			
			
			
