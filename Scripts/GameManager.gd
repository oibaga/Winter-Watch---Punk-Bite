extends Node3D

@onready var timer := $SessionTimer
@onready var anim := $AnimationPlayer
@export var ui_label: Label
var session_started := false

func start_session():
	if session_started:
		return

	session_started = true
	ui_label.visible = true

	# Toca animação da porta
	if anim:
		anim.play("fechar")

	# Inicia timer de 6 minutos
	timer.start()

	print("Sessão iniciada!")

func _process(delta):
	if session_started:
		var t := int(timer.time_left)
		ui_label.text = "%02d:%02d" % [t / 60, t % 60]
