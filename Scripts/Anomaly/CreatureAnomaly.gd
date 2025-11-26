extends Anomaly

@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D

func _ready() -> void:
	for anomaly in anomalies:
		anomaly.visible = false

func SpawnAnomaly():
	super.SpawnAnomaly()

	currentAnomaly = anomalies.pick_random()
	currentAnomaly.visible = true

func ResolveAnomaly():
	super.ResolveAnomaly()

	currentAnomaly.visible = false
	currentAnomaly = null
