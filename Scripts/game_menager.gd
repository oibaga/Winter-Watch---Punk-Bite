extends Node

@export var player: Node
@export var session_manager: Node
@export var ui_timer_label: Label

var session_started := false

func start_session():
	if session_started:
		return

	session_started = true

	# 1. Travar movimento do player
	if player.has_method("disable_movement"):
		player.disable_movement()

	# 2. Reproduzir animação da porta fechando
	$DoorAnimation.play("fechar")

	# 3. Iniciar o timer de 6 minutos
	$SessionTimer.start()

	# 4. Iniciar a parte das anomalias
	if session_manager.has_method("start_session"):
		session_manager.start_session()

	print("Sessão iniciada!")

func _process(delta):
	if session_started:
		var remaining := int($SessionTimer.time_left)
		ui_timer_label.text = str(remaining)
