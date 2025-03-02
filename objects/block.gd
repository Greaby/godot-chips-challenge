extends Area2D

@onready var raycast := $RayCast2D

func can_move_into(direction: Vector2, entity: Area2D) -> bool:
	if entity.is_in_group("block"):
		return false

	if entity.is_in_group("mob"):
		return false

	raycast.target_position = direction * Global.TILE_SIZE
	raycast.force_raycast_update()

	var collider = raycast.get_collider()

	if collider and !collider.has_method("can_move_into"):
		return false

	if collider and not collider.can_move_into(direction, self):
		return false

	_move(direction)

	return true

func _move(direction: Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * Global.TILE_SIZE, Global.MOVING_ANIMATION_SPEED)
	await tween.finished
