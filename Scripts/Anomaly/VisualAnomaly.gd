extends Anomaly

@export var sunRef : Sprite3D
@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D
const SUN = preload("res://Assets/Materiais/Sun.png")
const SUN_EYED = preload("res://Assets/Materiais/SunEyed.png")

func _ready() -> void:
	for anomaly in anomalies:
		anomaly.visible = false

func SpawnAnomaly():
	super.SpawnAnomaly()

	currentAnomaly = anomalies.pick_random()

	if sunRef:
		if currentAnomaly.is_in_group("SunChanger"):
			sunRef.texture = SUN_EYED
			sunRef.scale = Vector3(22,22,22)
	else:
		currentAnomaly.visible = true

func ResolveAnomaly():
	super.ResolveAnomaly()

	if currentAnomaly.is_in_group("SunChanger"):
		sunRef.texture = SUN
		sunRef.scale = Vector3(4,4,4)
	else:
		currentAnomaly.visible = false

	currentAnomaly = null
