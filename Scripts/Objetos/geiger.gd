class_name Geiger extends MeshInstance3D

@onready var target : Marker3D = $"../../../../Marker3D"
@export var mesh_with_outline : Sprite3D
@export var maxDistance : float = 12.4

var distance : float = 100:
	set(value):
		value = clampf(value, 0, maxDistance)
		distance = remap(value, 0, maxDistance, 100, 0)
		UpdateDistanceValues()
		
var wave_shader : ShaderMaterial = null

func _ready() -> void:
	if mesh_with_outline:
		var shaderMaterial = mesh_with_outline.material_override
		if shaderMaterial:
			if shaderMaterial is ShaderMaterial:
				wave_shader = shaderMaterial

func UpdateDistanceValues():
	var t = distance / 100.0  # 0.0 → 1.0

	wave_shader.set_shader_parameter("wave_amplitude", lerp(0.0, 0.355, t ))
	
	if distance > 75: wave_shader.set_shader_parameter("wave_speed", 35)
	else: wave_shader.set_shader_parameter("wave_speed", 9)
