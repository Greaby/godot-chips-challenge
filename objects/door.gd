@tool
extends Area2D

@export var type : Inventory.TYPES:
	set(new_type):
		type = new_type
		_set_sprite()

@export var quantity: int = 1:
	set(new_quantity):
		quantity = new_quantity
		_set_sprite()

@onready var sprite : Sprite2D = $Sprite2D
@onready var debug_label : Label = $DebugLabel

var sprite_types = {
	Inventory.TYPES.COIN : "res://assets/door_coin.png",
	Inventory.TYPES.RED_KEY: "res://assets/door_red.png",
	Inventory.TYPES.GREEN_KEY: "res://assets/door_green.png",
	Inventory.TYPES.BLUE_KEY: "res://assets/door_blue.png",
	Inventory.TYPES.YELLOW_KEY: "res://assets/door_yellow.png"
}

func _ready() -> void:
	_set_sprite()

func can_move_into(_direction: Vector2) -> bool:
	return Inventory.quantity(type) >= quantity

func interact() -> void:
	Inventory.remove(type, quantity)
	queue_free()

func _set_sprite() -> void:
	if not is_node_ready():
		return

	sprite.texture = load(sprite_types[type])

	if Engine.is_editor_hint():
		debug_label.text = "x%d" % quantity
	else:
		debug_label.hide()
