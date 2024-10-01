extends Area2D

signal entered

func can_move_into(_direction: Vector2) -> bool:
	return true


func interact() -> void:
	emit_signal("entered")
