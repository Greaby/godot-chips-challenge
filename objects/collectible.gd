@tool
extends Area2D


@export var type : Inventory.TYPES:
	set(new_type):
		type = new_type
		_set_sprite()

@onready var sprite : Sprite2D = $Sprite2D

var sprite_types = {
	Inventory.TYPES.COIN : "res://assets/apple.png",
	Inventory.TYPES.RED_KEY: "res://assets/key_red.png",
	Inventory.TYPES.GREEN_KEY: "res://assets/key_green.png",
	Inventory.TYPES.BLUE_KEY: "res://assets/key_blue.png",
	Inventory.TYPES.YELLOW_KEY: "res://assets/key_yellow.png",
	Inventory.TYPES.PALMS: "res://assets/palms.png",
	Inventory.TYPES.FIRE_BOOTS: "res://assets/fire_boots.png",
}

func _ready() -> void:
	_set_sprite()
	$AnimationPlayer.play("default")
	$AnimationPlayer.advance(randf())

func can_move_into(_direction: Vector2, entity: Area2D) -> bool:
	return entity.is_in_group("player")

func interact() -> void:
	Inventory.add(type, 1)
	queue_free()

func _set_sprite() -> void:
	if not is_node_ready():
		return

	sprite.texture = load(sprite_types[type])
