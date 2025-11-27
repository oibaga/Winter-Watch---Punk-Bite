extends Anomaly

const CRT_SHADER = preload("res://Shaders/GlitchAnomaly/CRTShader.tres")
const DERRETIMENTO_SHADER = preload("res://Shaders/GlitchAnomaly/DERRETIMENTOShader.tres")
const GLITCH_SHADER = preload("res://Shaders/GlitchAnomaly/GLITCHShader.tres")

var shaders = []

var targetColorRect : ColorRect = null

var defaultMaterial 

func _ready() -> void:
	targetColorRect = room.camera.color_rect

	defaultMaterial = targetColorRect.material.duplicate()

	shaders = [CRT_SHADER, DERRETIMENTO_SHADER, GLITCH_SHADER]

func SpawnAnomaly():
	super.SpawnAnomaly()

	targetColorRect.material = shaders.pick_random()

func ResolveAnomaly():
	super.ResolveAnomaly()

	targetColorRect.material = defaultMaterial
