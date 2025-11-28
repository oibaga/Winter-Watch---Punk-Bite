class_name Room extends Node

@export var camera: SecurityCamera
@export var geiger_support: GeigerSupport
@export var anomalyTimer : Timer
@export var anomalySpawnCooldown : float = 30

@export_category("Pressets")
@export var visual_anomaly: Anomaly
@export var sound_anomaly: Anomaly
@export var copy_anomaly: Anomaly
@export var glitch_anomaly: Anomaly
@export var creature_anomaly: Anomaly

var anomalyReference : Anomaly = null
var isGeigerRoom : bool = false
var gameManager : GameManager

func _ready() -> void:
	gameManager = get_tree().get_first_node_in_group("game_manager")
	
	anomalyTimer.connect("timeout", _on_anomaly_timer_timeout)

func SpawnRandomAnomaly() -> Anomaly:
	var possible = [
		visual_anomaly,
		sound_anomaly,
		copy_anomaly,
		glitch_anomaly,
		creature_anomaly
	].filter(func(a): return a != null)

	if possible.is_empty():
		return null

	anomalyReference = possible.pick_random()
	anomalyReference.SpawnAnomaly()

	return anomalyReference

func AnomalyResolved():
	await get_tree().create_timer( anomalySpawnCooldown ).timeout
	
	gameManager.ResolvedAnomaly( anomalyReference )
	
	anomalyReference = null

func _on_anomaly_timer_timeout() -> void:
	get_tree().call_deferred("reload_current_scene")
