class_name ObjetoInteragivel extends Area3D

@export var outline_mesh : MeshInstance3D
@export var hint_label : Label3D

func _ready() -> void:
	esconder_hint()

func mostrar_hint(_player : Player):
	if outline_mesh: outline_mesh.visible = true
	if hint_label: hint_label.visible = true

func esconder_hint(_player : Player = null):
	if outline_mesh: outline_mesh.visible = false
	if hint_label: hint_label.visible = false

func interagir():
	pass # ESTA DEVE SER SOBRESCRITA NAS FILHAS 

func pode_interagir(_player : Player) -> bool:
	return true
