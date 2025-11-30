extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label

var currentLevel : int = 0

func ChangeLevel():
	if currentLevel > 0 && currentLevel < 5: 
		get_tree().change_scene_to_file("res://Assets/cena_principal.tscn")
	else: 
		get_tree().change_scene_to_file("res://Levels/Menus/MainMenu.tscn")

		currentLevel = 0

	UpdateLevelLabel( currentLevel )

func LoadNextLevel(nextLevel : int):
	if nextLevel != currentLevel:
		var oldLevel : int = currentLevel

		currentLevel = nextLevel

	animation_player.play("Transition")

func UpdateLevelLabel(level : int):
	print("UpdateLevelLabel() chamado para Level ", level)
	if (level > 0 && level < 5): 
		label.text = str("Day ", level)
	else: 
		label.text = ""

func StartTransition():
	pass

func EndTransition():
	UpdateLevelLabel(0)
