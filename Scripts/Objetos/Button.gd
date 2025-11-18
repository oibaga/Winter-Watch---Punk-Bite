extends Area3D

@export var painel_tv: Node  # arraste o nó do painel (que tem o script de câmeras)
@onready var hint_label: Label3D = $HintLabel
@onready var outline_mesh: MeshInstance3D = %OutlineMouse

var olhando := false

func _ready():
	hint_label.visible = false
	if outline_mesh:
		outline_mesh.visible = false

func mostrar_hint():
	if not olhando:
		olhando = true
		hint_label.visible = true
		if outline_mesh:
			outline_mesh.visible = true

func esconder_hint():
	if olhando:
		olhando = false
		hint_label.visible = false
		if outline_mesh:
			outline_mesh.visible = false
		

func interagir():
	if painel_tv and painel_tv.has_method("trocar_camera"):
		painel_tv.trocar_camera()
