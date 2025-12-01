extends Control

var music : AudioStreamPlayer2D

func _ready() -> void:
	music = LevelManager.music
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	LevelManager.lastGeigerRoomID = -1

	LevelManager.repeat = false

	music.volume_linear = 0
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(music, "volume_linear", 0.8, 3)

func _on_play_pressed() -> void:
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(music, "volume_linear", 0, 1)

	LevelManager.LoadNextLevel(1)
	
	music.stop()

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/Credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().call_deferred("quit")
