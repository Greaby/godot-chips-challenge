extends Area2D


signal entered


func can_move() -> bool:
	return true


func interact() -> void:
	emit_signal("entered")
