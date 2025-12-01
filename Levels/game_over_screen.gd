extends Control

var canChoise : bool = true

func _ready() -> void:
	LevelManager.isToGameOver = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_esq") and canChoise:
		canChoise = false
		LevelManager.repeat = true
		LevelManager.LoadNextLevel(LevelManager.currentLevel)
	elif Input.is_action_just_pressed("exit") and canChoise:
		canChoise = false
		LevelManager.repeat = false
		LevelManager.LoadNextLevel(0)
