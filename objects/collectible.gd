extends Area2D

export (Inventory.TYPES) var type


func can_move() -> bool:
	return true

func interact() -> void:
	Inventory.add(type, 1)
	queue_free()
