extends Anomaly

@export var anomalies : Array[Node3D]
var currentAnomaly : Node3D
const SUN = preload("res://Shaders/SkyShaders/Sun.tres")
const SUN_EYED = preload("res://Shaders/SkyShaders/SunEyed.tres")
@export var world_environment: WorldEnvironment

func _ready() -> void:
	for anomaly in anomalies:
		anomaly.visible = false

func SpawnAnomaly():
	super.SpawnAnomaly()

	currentAnomaly = anomalies.pick_random()

	if world_environment:
		if currentAnomaly.is_in_group("SunChanger"):
			call_deferred("_apply_sun_material", SUN_EYED)
	else:
		currentAnomaly.visible = true

func ResolveAnomaly():
	super.ResolveAnomaly()

	if currentAnomaly.is_in_group("SunChanger"):
		call_deferred("_apply_sun_material", SUN)
	else:
		currentAnomaly.visible = false

	currentAnomaly = null

func _apply_sun_material(mat):
	if world_environment and world_environment.environment and world_environment.environment.sky:
		world_environment.environment.sky.sky_material = mat
