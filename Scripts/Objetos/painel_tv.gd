class_name PainelTV extends Node3D

@export var tela: Sprite3D
@export var viewports: Array[Viewport]

var indice_camera: int = -1
var ligado: bool = false

func _ready():
	await get_tree().process_frame
	desligar_tv()
	#ligar_tv()

func desligar_tv():
	ligado = false
	indice_camera = -1
	#tela.visible = false
	#tela.texture = null

func ligar_tv():
	ligado = true
	indice_camera = 0
	tela.visible = true
	atualizar_tela()

func trocar_camera():
	print("TrocarCamera")
	if not ligado:
		ligar_tv()
		return
	indice_camera += 1
	if indice_camera >= viewports.size():
		indice_camera = 0
	atualizar_tela()

func atualizar_tela():
	if indice_camera >= 0 and indice_camera < viewports.size():
		tela.texture = viewports[indice_camera].get_texture()
	
