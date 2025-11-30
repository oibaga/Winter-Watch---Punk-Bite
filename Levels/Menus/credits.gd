extends Control

var baga_itch = "https://oibaga.itch.io"
var baga_CaraApp = "https://cara.app/oibaga"
var hiisa_itch = "https://hiisa.itch.io"
var hiisa_portifolio = "https://sites.google.com/view/hiisarte"
var kayo_itch = "https://caioleaomarinho.itch.io"
var roo_itch = "https://rooneyhope.itch.io/"
var roo_X = "https://x.com/RooneyHopeDev"


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Menus/MainMenu.tscn")

func _on_itch_io_baga_pressed() -> void:
	OS.shell_open(baga_itch)

func _on_cara_app_pressed() -> void:
	OS.shell_open(baga_CaraApp)

func _on_itch_io_hiisa_pressed() -> void:
	OS.shell_open(hiisa_itch)

func _on_portifolio_hiisa_pressed() -> void:
	OS.shell_open(hiisa_portifolio)

func _on_itch_io_kayo_pressed() -> void:
	OS.shell_open(kayo_itch)


func _on_itch_io_rooney_pressed() -> void:
	OS.shell_open(roo_itch)


func _on_x_ronney_pressed() -> void:
	OS.shell_open(roo_X)
