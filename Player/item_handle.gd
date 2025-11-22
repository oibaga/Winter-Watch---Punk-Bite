extends Node3D

@export var itemMesh : MeshInstance3D

@export var itemsInInventory : Array[InventoryItem]

var current_item : InventoryItem :
	set(value): 
		current_item = value
		SwitchCurrentItem(value)

var current_index : int : 
	set(value): 
		current_index = (value + itemsInInventory.size()) % itemsInInventory.size()
		current_item = itemsInInventory[ current_index ]

func _ready() -> void:
	current_index = 0

func SwitchCurrentItem(item : InventoryItem):
	itemMesh = item.itemMesh
	item.position = item.targetPosition if item.targetPosition != Vector3.ZERO else self.position
	item.rotation = item.targetRotation if item.targetRotation != Vector3.ZERO else self.rotation

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_up"):
		current_index += 1
	elif event.is_action_pressed("scroll_down"):
		current_index -= 1
		
	elif event.is_action_pressed("mouse_esq"):
		current_item.LeftMouseClicked()
	elif event.is_action_pressed("mouse_dir"):
		current_item.RightMouseClicked()
