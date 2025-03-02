extends Area2D

signal die

@onready var raycast := $RayCast2D

var moving: bool = false
var is_die: bool = false

func _process(delta: float) -> void:
	if moving or is_die:
		return

	var direction = Vector2()
	direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if direction.x == 0:
		direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	if direction.length() == 0:
		$AnimatedSprite2D.play("idle")
		return

	raycast.target_position = direction * Global.TILE_SIZE
	raycast.force_raycast_update()

	var collider = raycast.get_collider()

	if collider and !collider.has_method("can_move_into"):
		_animation("push", direction)
		return

	if collider and not collider.can_move_into(direction, self):
		_animation("push", direction)
		return

	_move(direction, collider)

func _animation(name: String, direction: Vector2) -> void:
	match direction:
		Vector2.UP:
			$AnimatedSprite2D.play(name + "-up")
		Vector2.DOWN:
			$AnimatedSprite2D.play(name + "-down")
		Vector2.RIGHT:
			$AnimatedSprite2D.play(name + "-right")
		Vector2.LEFT:
			$AnimatedSprite2D.play(name + "-left")

func can_move_into(direction: Vector2, _entity: Area2D) -> bool:
	return true

func _move(direction: Vector2, collider) -> void:
	if collider and collider.is_in_group("block"):
		_animation("push", direction)
	else:
		_animation("walk", direction)

	var tween = create_tween()
	tween.tween_property(self, "position", position + direction * Global.TILE_SIZE, Global.MOVING_ANIMATION_SPEED)
	moving = true
	await tween.finished
	moving = false

func drown() -> void:
	$AnimatedSprite2D.play("drown")
	is_die = true
	die.emit()

func _on_Player_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		area.interact()
