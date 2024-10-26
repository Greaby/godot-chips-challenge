extends Area2D


func can_move_into(_direction: Vector2, entity: Area2D) -> bool:
	if entity.is_in_group("block"):
		return false

	return true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("mob"):
		_interact_mob(area)

	if area.is_in_group("player"):
		_interact_player(area)

func _interact_mob(mob: Area2D) -> void:
	mob.queue_free()

func _interact_player(player: Area2D) -> void:
	if not Inventory.has(Inventory.TYPES.FIRE_BOOTS):
		player.die.emit()
