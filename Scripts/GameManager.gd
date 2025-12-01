class_name GameManager extends Node

@export var cameraRooms : Node
@export var sessionTimer: Timer 
@export var ui_label: Label
@export var fade_rect: ColorRect
@export var end_label: Label
@export var hud_anim: AnimationPlayer
@export var geigerMarker3D : Marker3D
@export var geigerAnomaly : Timer
@export var paineltv : PainelTV

var geigerRoom : Room = null

var can_end : bool = true
var session_started: bool = false
var session_finished: bool = false

var anomaliesSlots : Array[Anomaly] = [null, null, null]

func _ready() -> void:
	SetRoomGeigerTarget()

func start_session():
	if session_started:
		return

	session_started = true
	ui_label.visible = true
	sessionTimer.start()
	geigerAnomaly.start()

	for i in range( anomaliesSlots.size() ):
		SpawnAnomaly(i)

	LevelManager.SessionStarted()

func _process(_delta):
	if session_started and not session_finished and can_end:
		var t := int(sessionTimer.time_left)

		# Atualiza o texto
		ui_label.text = "%02d:%02d" % [t / 60.0, t % 60]

		# Acabou o tempo
		if t <= 0:
			end_session()

func end_session():
	can_end = false

	ui_label.visible = false

	load_next_level()

func load_next_level():
	LevelManager.lastGeigerRoomID = geigerRoom.ID

	LevelManager.repeat = false

	LevelManager.LoadNextLevel( LevelManager.currentLevel + 1 )

func SetRoomGeigerTarget():
	if LevelManager.repeat:
		geigerRoom = cameraRooms.get_children().filter(func(a): return a.ID == LevelManager.lastGeigerRoomID).pick_random() as Room
	else:
		geigerRoom = cameraRooms.get_children().filter(func(a): return a.ID != LevelManager.lastGeigerRoomID).pick_random() as Room

	LevelManager.repeat = false

	geigerRoom.isGeigerRoom = true

	geigerMarker3D.global_position = geigerRoom.geiger_support.global_position

func ResolvedAnomaly(resolved : Anomaly):
	for i in range(anomaliesSlots.size()):
		if anomaliesSlots[i] == resolved:
			SpawnAnomaly(i)
			return

func SpawnAnomaly(arrayPos : int):
	anomaliesSlots[arrayPos] = cameraRooms.get_children().filter(func(a): return a.anomalyReference == null).pick_random().SpawnRandomAnomaly()
	print("Slot ", arrayPos, ": ", Anomaly.AnomalyTypes.find_key( anomaliesSlots[arrayPos].type ), " em ", anomaliesSlots[arrayPos].room.name)

	if anomaliesSlots[arrayPos].room.camera == paineltv.currentCamera:
		anomaliesSlots[arrayPos].ShowAnomaly(paineltv)

func LoseGame():
	if !can_end: return

	can_end = false

	sessionTimer.paused = true
	ui_label.visible = false
	
	LevelManager.lastGeigerRoomID = geigerRoom.ID

	LevelManager.LoadNextLevel( LevelManager.currentLevel, true )
