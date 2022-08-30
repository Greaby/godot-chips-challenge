extends Area2D


const TILE_SIZE = 64


onready var raycast := $RayCast2D


func _unhandled_input(event: InputEvent) -> void:
	var direction = Vector2()
	direction.x = int(event.is_action_pressed("move_right")) - int(event.is_action_pressed("move_left"))
	direction.y = int(event.is_action_pressed("move_down")) - int(event.is_action_pressed("move_up"))
	
	if direction.length() == 0:
		return
		
	raycast.cast_to = direction * TILE_SIZE
	raycast.force_raycast_update()
	
	var collider = raycast.get_collider()
	print(collider)
	if collider and !collider.has_method("can_move"):
		return
	
	if collider and not collider.can_move():
		return
		
	position += direction * TILE_SIZE


func _on_Player_area_entered(area: Area2D) -> void:
	print(area)
	if area.has_method("interact"):
		area.interact()
		
		print(Inventory.inventory)
