class_name Room extends Node

@export var camera: SecurityCamera
@export var geiger_support: GeigerSupport

@export_category("Pressets")
@export var visual_presset: VisualPresset
@export var sound_presset: SoundPresset
@export var geiger_presset: GeigerPresset
@export var copy_presset: CopyPresset
@export var glitch_presset: GlitchPresset
@export var creature_presset: CreaturePresset

var anomalyReference : Anomaly = null
var isGeigerRoom : bool = false

func SpawnRandomAnomaly():
	pass
