@tool
extends Area2D


@export var type : Inventory.TYPES:
	set(new_type):
		type = new_type
		_set_sprite()

@onready var sprite : Sprite2D = $Sprite2D

var sprite_types = {
	Inventory.TYPES.COIN : "res://assets/coin.png",
	Inventory.TYPES.RED_KEY: "res://assets/key_red.png",
	Inventory.TYPES.GREEN_KEY: "res://assets/key_green.png",
	Inventory.TYPES.BLUE_KEY: "res://assets/key_blue.png",
	Inventory.TYPES.YELLOW_KEY: "res://assets/key_yellow.png",
}

func _ready() -> void:
	_set_sprite()

func can_move_into(_direction: Vector2) -> bool:
	return true

func interact() -> void:
	Inventory.add(type, 1)
	queue_free()

func _set_sprite() -> void:
	if not is_node_ready():
		return

	sprite.texture = load(sprite_types[type])
