class_name PainelTV extends Node3D

@export var tela: Sprite3D
@export var viewports: Array[SecurityCamera]
@export var cooldownTimer : Timer
@export var lightsAnimationPlayer : AnimationPlayer
@export var gameManager : GameManager
@export var anomalyDefaultSound : AudioStreamPlayer2D

var canChose : bool = true
@export var geiger_proximity_sprite_3d: GeigerTV

var indice_camera: int = -1
var ligado: bool = false
var currentCamera : SecurityCamera = null

func _ready():
	geiger_proximity_sprite_3d.visible = false

	await get_tree().process_frame

	desligar_tv()

	geiger_proximity_sprite_3d.geigerMaxTimer = gameManager.geigerAnomaly.wait_time
	#ligar_tv()

func _process(delta: float) -> void:
	if !gameManager.geigerAnomaly.is_stopped():
		geiger_proximity_sprite_3d.proximity = gameManager.geigerAnomaly.time_left

func desligar_tv():
	ligado = false
	indice_camera = -1
	#tela.visible = false
	#tela.texture = null

func ligar_tv():
	ligado = true
	indice_camera = -1
	tela.visible = true

func trocar_camera():
	if not ligado:
		ligar_tv()
		
	if currentCamera:
		if currentCamera.room.anomalyReference:
			currentCamera.room.anomalyReference.HideAnomaly()

	indice_camera += 1
	if indice_camera >= viewports.size():
		indice_camera = 0

	currentCamera = viewports[indice_camera]

	if currentCamera.room.anomalyReference:
		currentCamera.room.anomalyReference.ShowAnomaly(self)

	atualizar_tela()

func atualizar_tela():
	if indice_camera >= 0 and indice_camera < viewports.size():
		tela.texture = currentCamera.get_texture()

		geiger_proximity_sprite_3d.visible = currentCamera.room.isGeigerRoom && ligado
		geiger_proximity_sprite_3d.audio.playing = currentCamera.room.isGeigerRoom && ligado

func ChoseAnomalyType(type : Anomaly.AnomalyTypes):
	canChose = false

	cooldownTimer.start()

	currentCamera.animationPlayer.play("Flash")
	
	if type == Anomaly.AnomalyTypes.GeigerType && currentCamera.room.isGeigerRoom:
		RightChoice(type)
	elif currentCamera.room.anomalyReference:
		if currentCamera.room.anomalyReference.type == type:
			RightChoice(type)
		else:
			WrongChoice(type)
	else:
		WrongChoice(type)

func RightChoice(type : Anomaly.AnomalyTypes):
	lightsAnimationPlayer.play("RightChoise")
	
	if type == Anomaly.AnomalyTypes.GeigerType:
		gameManager.geigerAnomaly.start()
		return
	
	currentCamera.room.anomalyReference.ResolveAnomaly()

func WrongChoice(_type : Anomaly.AnomalyTypes):
	lightsAnimationPlayer.play("WrongChoise")

func _on_cooldown_timer_timeout() -> void:
	lightsAnimationPlayer.play("ResetChoise")

	canChose = true
