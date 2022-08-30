extends Area2D


const TILE_SIZE = 64


onready var raycast := $RayCast2D


func _process(delta: float) -> void:
	var direction = Vector2()
	
	direction.x = int(Input.is_action_just_pressed("move_right")) - int(Input.is_action_just_pressed("move_left"))
	direction.y = int(Input.is_action_just_pressed("move_down")) - int(Input.is_action_just_pressed("move_up"))

	raycast.cast_to = direction * TILE_SIZE
	raycast.force_raycast_update()

	if not raycast.is_colliding():
		position += direction * TILE_SIZE


func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("collectible"):
		area.queue_free()
