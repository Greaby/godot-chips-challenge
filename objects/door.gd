@tool
extends Area2D

var type_sprites = {
	Inventory.TYPES.CHIPS : "res://assets/door_coin.png",
	Inventory.TYPES.RED_KEY: "res://assets/door_red.png",
	Inventory.TYPES.GREEN_KEY: "res://assets/door_green.png",
	Inventory.TYPES.BLUE_KEY: "res://assets/door_blue.png",
	Inventory.TYPES.YELLOW_KEY: "res://assets/door_yellow.png"
}

@export var type : Inventory.TYPES:
	set(new_type):
		type = new_type
		_set_sprite()


@export var quantity: int = 1


@onready var sprite : Sprite2D = $Sprite2D


func _ready() -> void:
	_set_sprite()

func can_move() -> bool:
	return Inventory.quantity(type) >= quantity


func interact() -> void:
	Inventory.remove(type, quantity)
	queue_free()

func _set_sprite() -> void:
	print(type_sprites[type])
	if sprite:
		sprite.texture = load(type_sprites[type])
