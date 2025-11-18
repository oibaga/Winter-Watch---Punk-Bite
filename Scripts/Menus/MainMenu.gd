extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level_test.tscn")


func _on_select_night_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/select_night.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/options.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
