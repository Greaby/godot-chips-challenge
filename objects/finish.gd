extends Area2D

signal entered

func can_move_into(_direction: Vector2, entity: Area2D) -> bool:
	return entity.is_in_group("player")


func interact() -> void:
	emit_signal("entered")
