extends Anomaly

@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D

func _ready() -> void:
	for anomaly in anomalies:
		anomaly.look_at(room.camera.camera_3d.global_position)

func SpawnAnomaly():
	super.SpawnAnomaly()
	currentAnomaly = anomalies.pick_random()
	currentAnomaly.visible = true

func ResolveAnomaly():
	super.ResolveAnomaly()

	room.AnomalyResolved()

	currentAnomaly.visible = false
	currentAnomaly = null
