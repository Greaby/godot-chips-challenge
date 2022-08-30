extends Node2D

const START_TILE :Vector2 = Vector2(3, 3)


func _ready() -> void:
	$Player.position = START_TILE * $TileMap.cell_size + $TileMap.cell_size / 2
