class_name Geiger extends MeshInstance3D

@export var mesh_with_outline : Sprite3D
@export var maxDistance : float = 12.4

var proximity : float = 100:
	set(value):
		value = clampf(value, 0, maxDistance)
		proximity = remap(value, 0, maxDistance, 100, 0)
		UpdateDistanceValues()

var wave_shader : ShaderMaterial = null

func _ready() -> void:
	if mesh_with_outline:
		var shaderMaterial = mesh_with_outline.material_override
		if shaderMaterial:
			if shaderMaterial is ShaderMaterial:
				wave_shader = shaderMaterial

func UpdateDistanceValues():
	var t = proximity / 100.0  # 0.0 → 1.0

	wave_shader.set_shader_parameter("wave_amplitude", lerp(0.0, 0.355, t ))

	if proximity > 82.5: wave_shader.set_shader_parameter("wave_speed", 35)
	elif proximity > 40: wave_shader.set_shader_parameter("wave_speed", 20)
	else: wave_shader.set_shader_parameter("wave_speed", 9)
