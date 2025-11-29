class_name Geiger extends MeshInstance3D

@export var mesh_with_outline : Sprite3D
@export var maxDistance : float = 12.4
var wave_shader : ShaderMaterial = null
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D
var default_volume : float = 0

var proximity : float = 100:
	set(value):
		value = clampf(value, 0, maxDistance)
		proximity = remap(value, 0, maxDistance, 100, 0)
		UpdateDistanceValues()

func _ready() -> void:
	default_volume = audio.volume_db
	
	if mesh_with_outline:
		var shaderMaterial = mesh_with_outline.material_override
		if shaderMaterial:
			if shaderMaterial is ShaderMaterial:
				wave_shader = shaderMaterial

func UpdateDistanceValues():
	var t = proximity / 100.0  # 0.0 → 1.0
	
	audio.pitch_scale = remap(proximity, 0, 100, 0.5, 4)

	wave_shader.set_shader_parameter("wave_amplitude", lerp(0.0, 0.355, t ))

	if wave_shader.get_shader_parameter("wave_amplitude") <= 0: audio.volume_db = -80
	else: audio.volume_db = default_volume

	if proximity > 82.5: wave_shader.set_shader_parameter("wave_speed", 35)
	elif proximity > 40: wave_shader.set_shader_parameter("wave_speed", 20)
	else: wave_shader.set_shader_parameter("wave_speed", 9)
