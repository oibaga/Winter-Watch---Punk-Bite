extends Node

@export var timer: Timer 
@export var ui_label: Label
@export var fade_rect: ColorRect
@export var end_label: Label
@export var hud_anim: AnimationPlayer

var session_started: bool = false
var session_finished: bool = false
var can_continue: bool = false


func start_session():
	if session_started:
		return

	session_started = true
	ui_label.visible = true
	timer.start()


func _process(_delta):
	if session_started and not session_finished:
		var t := int(timer.time_left)

		# Atualiza o texto
		ui_label.text = "%02d:%02d" % [t / 60.0, t % 60]

		# Acabou o tempo
		if t <= 0:
			end_session()

	# Após o fade, permite clicar para continuar
	if session_finished and can_continue:
		if Input.is_action_just_pressed("mouse_esq") or Input.is_action_just_pressed("ui_accept"):
			load_next_level()


func end_session():
	session_finished = true
	ui_label.visible = false

	# Toca o fade
	if hud_anim:
		hud_anim.play("fade_out")

	# Espera 2 segundos antes de permitir clicar
	await get_tree().create_timer(2.0).timeout
	can_continue = true


func load_next_level():
	print("Carregando próxima fase...")
	
	get_tree().quit()
	# Trocar a cena aqui
	# Exemplo:
	# get_tree().change_scene_to_file("res://levels/fase02.tscn")
