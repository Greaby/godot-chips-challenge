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

	position += direction * Global.TILE_SIZE
	return true




func _on_area_entered(area: Area2D) -> void:
	print("_on_area_entered")
	print(area)




func _on_body_entered(body: Node2D) -> void:
	print("_on_body_entered")
