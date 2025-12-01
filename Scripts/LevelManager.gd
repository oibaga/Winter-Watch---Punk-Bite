extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
var isToGameOver : bool = false
@onready var color_rect: ColorRect = $ColorRect

signal isGeigerPlaced
signal isManualRead
signal isSessionStarted
signal isInspectionStarted

var currentLevel : int = 0
var lastGeigerRoomID : int = -1
var repeat : bool = false

func SessionStarted():
	emit_signal("isSessionStarted")

func ManualRead():
	emit_signal("isManualRead")

func GeigerPlaced():
	emit_signal("isGeigerPlaced")

func InspectionStarted():
	emit_signal("isInspectionStarted")

func ChangeLevel():
	if isToGameOver:
		get_tree().change_scene_to_file("res://Levels/GameOverScreen.tscn")
		return

	if currentLevel > 0 && currentLevel < 5: 
		get_tree().change_scene_to_file("res://Assets/cena_principal.tscn")
	else: 
		currentLevel = 0

		get_tree().change_scene_to_file("res://Levels/Menus/MainMenu.tscn")

	UpdateLevelLabel( currentLevel )

func LoadNextLevel(nextLevel : int, isGameOver : bool = false):
	isToGameOver = isGameOver

	if isToGameOver:
		animation_player.play("FadeIn")
		return

	currentLevel = nextLevel

	animation_player.play("Transition")

func UpdateLevelLabel(level : int):
	if (level > 0 && level < 5): 
		label.text = str("Day ", level)
	else: 
		label.text = ""

func StartTransition():
	pass

func EndTransition():
	UpdateLevelLabel(0)

	if isToGameOver:
		color_rect.color.a = 0
