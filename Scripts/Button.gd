extends Area3D

@export var painel_tv: Node  # arraste o nó do painel (que tem o script de câmeras)
@onready var mesh_button: MeshInstance3D = $MeshInstance3D
@onready var hint_label: Label3D = $HintLabel

var olhando := false
var emissive_mat: StandardMaterial3D

func _ready():
	hint_label.visible = false
	
	# duplicar o material do botão para aplicar o brilho sem afetar outros objetos
	if mesh_button.material_override:
		emissive_mat = mesh_button.material_override.duplicate()
	else:
		emissive_mat = StandardMaterial3D.new()
	mesh_button.material_override = emissive_mat
	
	emissive_mat.emission_enabled = false

func mostrar_hint():
	if not olhando:
		olhando = true
		hint_label.visible = true
		# liga o contorno branco (simula outline com emissive)
		emissive_mat.emission_enabled = true
		emissive_mat.emission = Color(1, 1, 1)
		emissive_mat.emission_energy_multiplier = 1.5

func esconder_hint():
	if olhando:
		olhando = false
		hint_label.visible = false
		emissive_mat.emission_enabled = false

func interagir():
	if painel_tv and painel_tv.has_method("trocar_camera"):
		painel_tv.trocar_camera()
