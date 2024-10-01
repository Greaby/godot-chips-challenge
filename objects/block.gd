extends Area2D

@onready var raycast := $RayCast2D

func can_move_into(direction: Vector2) -> bool:

	raycast.target_position = direction * Global.TILE_SIZE
	raycast.force_raycast_update()

	var collider = raycast.get_collider()
	print(raycast.target_position, collider)
	if collider and !collider.has_method("can_move_into"):
		return false

	if collider and not collider.can_move_into(direction):
		return false

	position += direction * Global.TILE_SIZE
	return true
