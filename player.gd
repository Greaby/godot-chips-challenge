extends Area2D

signal die

@onready var raycast := $RayCast2D

var moving: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return

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

	if collider and not collider.can_move_into(direction, self):
		return

	_move(direction)

func can_move_into(direction: Vector2, _entity: Area2D) -> bool:
	return true

func _move(direction: Vector2) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * Global.TILE_SIZE, 0.1).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false

func _on_Player_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		area.interact()
