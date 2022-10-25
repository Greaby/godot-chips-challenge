extends Area2D

@export var type : Inventory.TYPES
@export var quantity : int


func can_move() -> bool:
	return Inventory.quantity(type) >= quantity


func interact() -> void:
	Inventory.remove_at(type, quantity)
	queue_free()
