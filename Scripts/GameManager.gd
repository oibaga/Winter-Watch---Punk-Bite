class_name GameManager extends Node

@export var cameraRooms : Node
@export var sessionTimer: Timer 
@export var ui_label: Label
@export var fade_rect: ColorRect
@export var end_label: Label
@export var hud_anim: AnimationPlayer
@export var geigerMarker3D : Marker3D
@export var geigerAnomaly : Timer
var geigerRoom : Room = null

var session_started: bool = false
var session_finished: bool = false
var can_continue: bool = false

var anomaliesSlots : Array[Anomaly]

func _ready() -> void:
	SetRoomGeigerTarget()

func start_session():
	if session_started:
		return

	session_started = true
	ui_label.visible = true
	sessionTimer.start()
	geigerAnomaly.start()

func _process(_delta):
	if session_started and not session_finished:
		var t := int(sessionTimer.time_left)

		# Atualiza o texto
		ui_label.text = "%02d:%02d" % [t / 60.0, t % 60]

		# Acabou o tempo
		if t <= 0:
			end_session()

	# Após o fade, permite clicar para continuar
	if session_finished and can_continue:
		if Input.is_action_just_pressed("mouse_esq") or Input.is_action_just_pressed("ui_accept"):
			load_next_level()

func end_session():
	session_finished = true
	ui_label.visible = false

	# Toca o fade
	if hud_anim:
		hud_anim.play("fade_out")
		await hud_anim.animation_finished

	can_continue = true

func load_next_level():
	print("Carregando próxima fase...")

	get_tree().call_deferred("quit")
	# Trocar a cena aqui
	# Exemplo:
	# get_tree().change_scene_to_file("res://levels/fase02.tscn")

func SetRoomGeigerTarget():
	geigerRoom = cameraRooms.get_children().pick_random() as Room

	geigerRoom.isGeigerRoom = true

	geigerMarker3D.global_position = geigerRoom.geiger_support.global_position

func ResolvedAnomaly(resolved : Anomaly):
	for i in range(anomaliesSlots.size()):
		if anomaliesSlots[i] == resolved:
			anomaliesSlots[i] = cameraRooms.get_children().filter(func(a): return a.anomalyReference == null).pick_random().SpawnRandomAnomaly()
			return
