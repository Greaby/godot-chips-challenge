extends Area2D


@onready var raycast := $RayCast2D


func _unhandled_input(event: InputEvent) -> void:
	var direction = Vector2()
	direction.x = int(event.is_action_pressed("move_right")) - int(event.is_action_pressed("move_left"))
	direction.y = int(event.is_action_pressed("move_down")) - int(event.is_action_pressed("move_up"))

	if direction.length() == 0:
		return

	raycast.target_position = direction * Global.TILE_SIZE
	raycast.force_raycast_update()

	var collider = raycast.get_collider()

	if collider and !collider.has_method("can_move_into"):
		return

	if collider and not collider.can_move_into(direction):
		return

	position += direction * Global.TILE_SIZE


func _on_Player_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		area.interact()
