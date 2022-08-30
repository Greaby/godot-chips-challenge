extends Node

enum TYPES {
	CHIPS,
	RED_KEY,
	GREEN_KEY,
	BLUE_KEY,
	YELLOW_KEY
}

var inventory : = {}


func add(type: int, quantity: int) -> void:
	if not inventory.has(type):
		inventory[type] = 0
	
	inventory[type] += quantity


func remove(type: int, quantity: int) -> void:
	if not inventory.has(type):
		return

	inventory[type] = clamp(inventory[type] - quantity, 0, INF) 


func quantity(type: int) -> int:
	if not inventory.has(type):
		return 0
		
	return inventory[type]


func has(type: int) -> bool:
	return self.quantity(type) > 0
