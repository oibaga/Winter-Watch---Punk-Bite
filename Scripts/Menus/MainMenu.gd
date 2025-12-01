extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	LevelManager.lastGeigerRoomID = -1
	
	LevelManager.repeat = false

func _on_play_pressed() -> void:
	LevelManager.LoadNextLevel(1)

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/Credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
