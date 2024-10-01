extends Area2D

signal attack

@onready var raycast: RayCast2D = $RayCast2D

const DIRECTIONS = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]

func tick() -> void:
	rotate(PI / -2)
	get_direction()

func can_move_into(_direction: Vector2) -> bool:
	return true

func interact() -> void:
	attack.emit()

func get_direction(index: int = 0) -> void:
	if index >= 4:
		return

	raycast.force_raycast_update()
	var collider = raycast.get_collider()

	var direction = raycast.target_position.rotated(rotation).normalized() * Global.TILE_SIZE

	if collider and (!collider.has_method("can_move_into") or not collider.can_move_into(direction)):
		rotate(PI / 2)
		return get_direction(index + 1)


	position += direction
	return
