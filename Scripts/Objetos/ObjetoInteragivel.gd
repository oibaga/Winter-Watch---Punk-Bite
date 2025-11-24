class_name ObjetoInteragivel extends Area3D

@export var mesh_with_outline : MeshInstance3D
@export var hint_label : Label3D

var outline_material : ShaderMaterial = null

func _ready() -> void:
	if mesh_with_outline:
		var shaderMaterial = mesh_with_outline.material_overlay
		if shaderMaterial:
			if shaderMaterial is ShaderMaterial:
				outline_material = shaderMaterial
	
	esconder_hint()

func mostrar_hint(_player : Player):
	if outline_material: outline_material.set_shader_parameter("active", true)
	if hint_label: hint_label.visible = true

func esconder_hint(_player : Player = null):
	if outline_material: outline_material.set_shader_parameter("active", false)
	if hint_label: hint_label.visible = false

func interagir(_player : Player):
	pass # ESTA DEVE SER SOBRESCRITA NAS FILHAS 

func pode_interagir(_player : Player) -> bool:
	return true
