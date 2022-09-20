extends Area2D


onready var timer := $Timer
onready var raycast: RayCast2D = $RayCast2D

const DIRECTIONS = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]


func _ready() -> void:
	timer.start()



func _on_Timer_timeout() -> void:
	var direction = get_direction()
	
	#rotation = direction.angle()
	
	position += direction * Global.TILE_SIZE



func get_direction(index: int = 0) -> Vector2:
	if index > DIRECTIONS.size() -1:
		return Vector2.ZERO

	raycast.cast_to = DIRECTIONS[index] * Global.TILE_SIZE
	raycast.force_raycast_update()
	
	var collider = raycast.get_collider()
	
	if not collider:
		return DIRECTIONS[index]
	
	return get_direction(index + 1)
