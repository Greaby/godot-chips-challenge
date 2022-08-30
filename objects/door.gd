extends Area2D

export (Inventory.TYPES) var type : int
export (int) var quantity : int


func can_move() -> bool:
	return Inventory.quantity(type) >= quantity


func interact() -> void:
	Inventory.remove(type, quantity)
	queue_free()
