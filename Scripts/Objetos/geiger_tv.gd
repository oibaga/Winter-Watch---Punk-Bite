class_name GeigerTV extends Sprite3D

var geigerMaxTimer : float = 10
@onready var audio: AudioStreamPlayer3D = $"../Caixa/AudioStreamPlayer3D"
var default_volume : float = 0
var wave_shader : ShaderMaterial = null

var proximity : float = 100:
	set(value):
		value = clampf(value, 0, geigerMaxTimer)
		proximity = remap(value, 0, geigerMaxTimer, 100, 0)
		UpdateDistanceValues()

func _ready() -> void:
	default_volume = audio.volume_db
	audio.volume_db = -80
	
	var shaderMaterial = self.material_override
	if shaderMaterial:
		if shaderMaterial is ShaderMaterial:
			wave_shader = shaderMaterial

func UpdateDistanceValues():
	if !wave_shader: return
	
	audio.pitch_scale = remap(proximity, 0, 100, 0.1, 4)
	audio.volume_db = default_volume if audio.pitch_scale >= 0.5 else -80
	
	var t = proximity / 100.0  # 0.0 → 1.0

	wave_shader.set_shader_parameter("wave_amplitude", lerp(0.0, 0.355, t ))

	if proximity > 82.5: wave_shader.set_shader_parameter("wave_speed", 35)
	elif proximity > 40: wave_shader.set_shader_parameter("wave_speed", 20)
	else: wave_shader.set_shader_parameter("wave_speed", 9)
