class_name GeigerTV extends Sprite3D

var geigerMaxTimer : float = 10

var wave_shader : ShaderMaterial = null

var proximity : float = 100:
	set(value):
		value = clampf(value, 0, geigerMaxTimer)
		proximity = remap(value, 0, geigerMaxTimer, 100, 0)
		UpdateDistanceValues()

func _ready() -> void:
	var shaderMaterial = self.material_override
	if shaderMaterial:
		if shaderMaterial is ShaderMaterial:
			wave_shader = shaderMaterial

func UpdateDistanceValues():
	if !wave_shader: return

	var t = proximity / 100.0  # 0.0 → 1.0

	wave_shader.set_shader_parameter("wave_amplitude", lerp(0.0, 0.355, t ))

	if proximity > 82.5: wave_shader.set_shader_parameter("wave_speed", 35)
	elif proximity > 40: wave_shader.set_shader_parameter("wave_speed", 20)
	else: wave_shader.set_shader_parameter("wave_speed", 9)
