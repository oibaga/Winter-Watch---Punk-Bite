class_name InventoryItem extends Node3D

@export var IsPickable : bool = true
@export var itemName : String
@export var itemMesh : MeshInstance3D
@export var itemIcon : Sprite2D
@export var targetPosition : Vector3 = Vector3.ZERO
@export var targetRotation : Vector3 = Vector3.ZERO

func RightMouseClicked():
	pass

func LeftMouseClicked():
	pass
