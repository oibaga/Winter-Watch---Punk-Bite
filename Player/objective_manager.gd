class_name ObjectiveManager extends Sprite3D

@export var player : Player
@export var cadeira : Cadeira
@export var manual : ManualFechado

var manualRead : bool = false
var geigerPlaced : bool = false

func _ready() -> void:
	SetNewObjective( manual )

	LevelManager.isGeigerPlaced.connect( OnGeigerPlaced )
	LevelManager.isManualRead.connect( OnManualRead )
	LevelManager.isSessionStarted.connect( OnSessionStarted )

@export var min_scale: float = 0.1            # escala mínima permitida
@export var max_scale: float = 1            # escala máxima permitida
@export var min_distance: float = 3.0         # distância onde o tamanho fica no min_scale
@export var max_distance: float = 12.0        # distância onde o tamanho chega ao max_scale

func _process(delta: float) -> void:
	if !visible or !player:
		return

	update_fixed_size()

func SetNewObjective(node : Node3D):
	if node:
		visible = true
		global_position = node.global_position
	else:
		visible = false

func update_fixed_size():
	var dist = global_position.distance_to(player.global_position)

	# Normaliza a distância para 0–1
	var t = clampf((dist - min_distance) / (max_distance - min_distance), 0.0, 1.0)

	# Escala interpolada entre min e max
	var target_scale = lerp(min_scale, max_scale, t)

	scale = Vector3.ONE * target_scale


func OnManualRead():
	if manualRead: return
	manualRead = true

	if !geigerPlaced:
		SetNewObjective( null )

func OnGeigerPlaced():
	SetNewObjective( cadeira )

func OnSessionStarted():
	SetNewObjective( null )
