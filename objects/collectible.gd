extends Area2D


@export var type : Inventory.TYPES


func can_move() -> bool:
	return true

func interact() -> void:
	Inventory.add(type, 1)
	queue_free()
